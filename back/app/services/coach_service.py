from datetime import date
from typing import List

from sqlalchemy.ext.asyncio import AsyncSession

from app.models.user import User
from app.repositories.analytics_repository import AnalyticsRepository
from app.repositories.habit_log_repository import HabitLogRepository
from app.repositories.habit_repository import HabitRepository
from app.repositories.user_repository import UserRepository
from app.schemas.coach import CoachInsightOut, CoachInsightsOut, CoachSummaryOut


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
