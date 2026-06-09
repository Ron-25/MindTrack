from datetime import date
from typing import List

from sqlalchemy.ext.asyncio import AsyncSession

from app.models.user import User
from app.repositories.analytics_repository import AnalyticsRepository
from app.schemas.analytics import CorrelationPointOut, FrequencyItemOut, WeeklySummaryOut
from app.schemas.emotion_type import EmotionTypeOut


class AnalyticsService:
    def __init__(self, db: AsyncSession):
        self.repo = AnalyticsRepository(db)

    async def weekly_summary(self, user: User, week_start: date) -> WeeklySummaryOut:
        week_end = date.fromordinal(week_start.toordinal() + 6)

        avg_intensity = await self.repo.avg_intensity(user.id, week_start)
        dominant_emotion_id, total_logs = await self.repo.get_week_emotion_stats(
            user.id, week_start, week_end
        )
        habits_completion_pct = await self.repo.get_habit_completion_pct(
            user.id, week_start, week_end
        )

        summary = await self.repo.upsert_weekly_summary(
            user_id=user.id,
            week_start=week_start,
            dominant_emotion_id=dominant_emotion_id,
            avg_intensity=float(avg_intensity) if avg_intensity is not None else None,
            total_logs=total_logs,
            habits_completion_pct=habits_completion_pct,
        )

        dominant_emotion_out = None
        if dominant_emotion_id:
            emotion_type = await self.repo.get_emotion_type(dominant_emotion_id)
            if emotion_type:
                dominant_emotion_out = EmotionTypeOut.model_validate(emotion_type)

        return WeeklySummaryOut(
            id=summary.id,
            week_start=summary.week_start,
            dominant_emotion=dominant_emotion_out,
            avg_intensity=float(summary.avg_intensity) if summary.avg_intensity is not None else None,
            total_logs=summary.total_logs,
            habits_completion_pct=float(summary.habits_completion_pct) if summary.habits_completion_pct is not None else None,
            insight_text=summary.insight_text,
        )

    async def emotion_frequency(self, user: User, days: int = 30) -> List[FrequencyItemOut]:
        raw = await self.repo.emotion_frequency(user.id, days)
        return [
            FrequencyItemOut(
                emotion_type=EmotionTypeOut.model_validate(item["emotion_type"]),
                count=item["count"],
                percentage=item["percentage"],
            )
            for item in raw
        ]

    async def habits_vs_mood(self, user: User, days: int = 30) -> List[CorrelationPointOut]:
        raw = await self.repo.habits_vs_mood(user.id, days)
        return [
            CorrelationPointOut(
                date=item["date"],
                habits_completed=item["habits_completed"],
                avg_intensity=item["avg_intensity"],
            )
            for item in raw
        ]
