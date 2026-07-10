from datetime import date
import logging
from typing import List

import httpx
from fastapi import HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.config import settings
from app.models.user import User
from app.repositories.analytics_repository import AnalyticsRepository
from app.repositories.habit_log_repository import HabitLogRepository
from app.repositories.habit_repository import HabitRepository
from app.repositories.user_repository import UserRepository
from app.schemas.coach import (
    CoachChatIn,
    CoachChatOut,
    CoachInsightOut,
    CoachInsightsOut,
    CoachSummaryOut,
)

OPENAI_CHAT_URL = "https://api.openai.com/v1/chat/completions"

MAX_HISTORY_MESSAGES = 20
logger = logging.getLogger(__name__)


class CoachService:
    def __init__(self, db: AsyncSession):
        self.analytics_repo = AnalyticsRepository(db)
        self.habit_repo = HabitRepository(db)
        self.habit_log_repo = HabitLogRepository(db)
        self.user_repo = UserRepository(db)

    async def get_insights(self, user: User) -> CoachInsightsOut:
        user_with_prefs = await self.user_repo.get_with_preferences(user.id)
        language = (
            user_with_prefs.preferences.language
            if user_with_prefs and user_with_prefs.preferences
            else "es"
        ).lower()

        today = date.today()
        week_start = date.fromordinal(today.toordinal() - today.weekday())
        week_end = date.fromordinal(week_start.toordinal() + 6)

        avg_intensity = await self.analytics_repo.avg_intensity(user.id, week_start)
        dominant_emotion_id, total_logs = await self.analytics_repo.get_week_emotion_stats(
            user.id,
            week_start,
            week_end,
        )
        habits_completion_pct = await self.analytics_repo.get_habit_completion_pct(
            user.id,
            week_start,
            week_end,
        )

        dominant_emotion_name = None
        if dominant_emotion_id:
            emotion_type = await self.analytics_repo.get_emotion_type(dominant_emotion_id)
            if emotion_type:
                dominant_emotion_name = (
                    emotion_type.name_es
                    if language.startswith("es") and emotion_type.name_es
                    else emotion_type.name
                )

        active_habits = await self.habit_repo.list_active_by_user(user.id)
        pending_habits_count = 0
        for habit in active_habits:
            log = await self.habit_log_repo.get_by_habit_and_date(habit.id, today)
            if not log or log.status != "done":
                pending_habits_count += 1

        frequency = await self.analytics_repo.emotion_frequency(user.id, 30)
        top_emotion_name = None
        if frequency:
            emotion_type = frequency[0]["emotion_type"]
            top_emotion_name = (
                emotion_type.name_es
                if language.startswith("es") and emotion_type.name_es
                else emotion_type.name
            )

        insights = self._build_insights(
            language=language,
            total_logs=total_logs,
            avg_intensity=float(avg_intensity) if avg_intensity is not None else None,
            habits_completion_pct=habits_completion_pct,
            pending_habits_count=pending_habits_count,
            top_emotion_name=top_emotion_name,
            has_habits=bool(active_habits),
        )

        return CoachInsightsOut(
            hero_label="Coach IA" if language.startswith("es") else "AI Coach",
            hero_description=(
                "Sugerencias accionables basadas en tu actividad reciente."
                if language.startswith("es")
                else "Actionable suggestions based on your recent activity."
            ),
            insights=insights,
            summary=CoachSummaryOut(
                total_logs=total_logs,
                avg_intensity=float(avg_intensity) if avg_intensity is not None else None,
                habits_completion_pct=habits_completion_pct,
                dominant_emotion_name=dominant_emotion_name,
                pending_habits_count=pending_habits_count,
            ),
        )

    async def chat(self, user: User, body: CoachChatIn) -> CoachChatOut:
        if not settings.openai_api_key:
            raise HTTPException(
                status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
                detail="El asistente no está configurado (falta OPENAI_API_KEY).",
            )

        message = body.message.strip()
        if not message:
            raise HTTPException(
                status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
                detail="El mensaje no puede estar vacío.",
            )

        insights = await self.get_insights(user)
        summary = insights.summary
        context_lines = [
            f"Registros emocionales esta semana: {summary.total_logs}.",
            f"Hábitos pendientes hoy: {summary.pending_habits_count}.",
        ]
        if summary.avg_intensity is not None:
            context_lines.append(
                f"Intensidad emocional promedio: {summary.avg_intensity:.1f}/10."
            )
        if summary.habits_completion_pct is not None:
            context_lines.append(
                f"Cumplimiento de hábitos semanal: {summary.habits_completion_pct:.0f}%."
            )
        if summary.dominant_emotion_name:
            context_lines.append(
                f"Emoción dominante de la semana: {summary.dominant_emotion_name}."
            )

        system_prompt = (
            "Eres MindtrackBot, el coach de bienestar emocional de la app MindTrack. "
            "Responde con calidez, en el idioma del usuario, en 2-4 frases claras y "
            "accionables. Puedes sugerir registrar emociones, revisar hábitos o "
            "técnicas breves de bienestar (respiración, journaling, caminatas). "
            "No des diagnósticos médicos; si detectas crisis sugiere buscar ayuda "
            "profesional. Contexto reciente del usuario: " + " ".join(context_lines)
        )

        contents = [
            {"role": item.role, "parts": [{"text": item.content}]}
            for item in body.history[-MAX_HISTORY_MESSAGES:]
            if item.content.strip()
        ]
        contents.append({"role": "user", "parts": [{"text": message}]})

        payload = {
            "system_instruction": {"parts": [{"text": system_prompt}]},
            "contents": contents,
            "generationConfig": {"temperature": 0.6, "maxOutputTokens": 500},
        }

        url = f"{GEMINI_BASE_URL}/{settings.gemini_model}:generateContent"
        try:
            async with httpx.AsyncClient(timeout=30) as client:
                response = await client.post(
                    url,
                    json=payload,
                    headers={"x-goog-api-key": settings.gemini_api_key},
                )
        except httpx.HTTPError:
            logger.exception("Error de red al contactar la API de Gemini")
            raise HTTPException(
                status_code=status.HTTP_502_BAD_GATEWAY,
                detail="No se pudo contactar al asistente. Intenta de nuevo.",
            )

        if response.status_code == 429:
            logger.warning("Gemini rechazó la solicitud por límite de uso (429)")
            raise HTTPException(
                status_code=status.HTTP_429_TOO_MANY_REQUESTS,
                detail=(
                    "El asistente alcanzó el límite gratuito por ahora. "
                    "Intenta de nuevo en unos minutos."
                ),
            )
        if response.status_code != 200:
            try:
                upstream_error = response.json().get("error", {})
                upstream_message = upstream_error.get("message", response.text)
            except (ValueError, AttributeError):
                upstream_message = response.text
            logger.error(
                "Gemini respondió HTTP %s: %s",
                response.status_code,
                upstream_message[:1000],
            )
            raise HTTPException(
                status_code=status.HTTP_502_BAD_GATEWAY,
                detail=(
                    "Gemini rechazó la solicitud "
                    f"(error {response.status_code}). Revisa los logs de Render."
                ),
            )

        try:
            data = response.json()
        except ValueError:
            logger.error("Gemini devolvió una respuesta que no es JSON")
            raise HTTPException(
                status_code=status.HTTP_502_BAD_GATEWAY,
                detail="Gemini devolvió una respuesta inválida.",
            )
        try:
            reply = data["candidates"][0]["content"]["parts"][0]["text"].strip()
        except (KeyError, IndexError, TypeError):
            logger.error("Respuesta de Gemini sin texto: %s", str(data)[:1000])
            raise HTTPException(
                status_code=status.HTTP_502_BAD_GATEWAY,
                detail="El asistente devolvió una respuesta vacía. Intenta de nuevo.",
            )

        return CoachChatOut(reply=reply)

    def _build_insights(
        self,
        *,
        language: str,
        total_logs: int,
        avg_intensity: float | None,
        habits_completion_pct: float | None,
        pending_habits_count: int,
        top_emotion_name: str | None,
        has_habits: bool,
    ) -> List[CoachInsightOut]:
        is_es = language.startswith("es")
        insights: List[CoachInsightOut] = []

        if total_logs < 3:
            insights.append(
                CoachInsightOut(
                    code="low_logs",
                    priority="medium",
                    message=(
                        "Esta semana todavía hay pocos registros. Intenta anotar al menos una emoción por la mañana y otra por la noche para mejorar tus patrones."
                        if is_es
                        else "There are still few logs this week. Try noting at least one emotion in the morning and one at night to improve your patterns."
                    ),
                )
            )

        if (avg_intensity or 0) >= 7:
            insights.append(
                CoachInsightOut(
                    code="high_intensity",
                    priority="high",
                    message=(
                        "Tu intensidad emocional promedio viene alta. Considera una pausa breve hoy: respiración guiada, caminata corta o journaling."
                        if is_es
                        else "Your average emotional intensity is trending high. Consider a short pause today: guided breathing, a short walk, or journaling."
                    ),
                )
            )

        if has_habits and (habits_completion_pct or 0) < 50:
            insights.append(
                CoachInsightOut(
                    code="low_habit_consistency",
                    priority="high",
                    message=(
                        "Tu constancia en hábitos está por debajo del 50%. Enfócate en completar solo un hábito clave hoy para recuperar tracción."
                        if is_es
                        else "Your habit consistency is below 50%. Focus on completing just one key habit today to regain traction."
                    ),
                )
            )

        if pending_habits_count > 0:
            insights.append(
                CoachInsightOut(
                    code="pending_habits",
                    priority="medium",
                    message=(
                        f"Aún tienes {pending_habits_count} hábito(s) pendiente(s) hoy. El más fácil de completar ahora mismo puede darte un pequeño impulso de avance."
                        if is_es
                        else f"You still have {pending_habits_count} habit(s) pending today. The easiest one to complete right now may give you a useful momentum boost."
                    ),
                )
            )

        if top_emotion_name:
            insights.append(
                CoachInsightOut(
                    code="top_emotion",
                    priority="low",
                    message=(
                        f"La emoción más frecuente recientemente es {top_emotion_name.lower()}. Vale la pena revisar qué actividades o personas suelen aparecer junto a ella."
                        if is_es
                        else f"Your most frequent recent emotion is {top_emotion_name.lower()}. It is worth checking what activities or people usually appear alongside it."
                    ),
                )
            )

        if not insights:
            insights.append(
                CoachInsightOut(
                    code="balanced",
                    priority="low",
                    message=(
                        "Tus métricas se ven equilibradas. Mantén el ritmo y revisa tus hábitos más consistentes para reforzar lo que ya te funciona."
                        if is_es
                        else "Your metrics look balanced. Keep the rhythm and review your most consistent habits to reinforce what is already working."
                    ),
                )
            )

        return insights
