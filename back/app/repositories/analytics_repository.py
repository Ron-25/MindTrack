from datetime import date
from typing import List, Optional, Tuple
from uuid import UUID

from sqlalchemy import cast, Date, func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.emotion import EmotionLog, EmotionType
from app.models.habit import Habit, HabitLog
from app.models.summary import WeeklySummary


class AnalyticsRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def emotion_frequency(self, user_id: UUID, days: int) -> List[dict]:
        since = func.now() - func.make_interval(0, 0, 0, days)
        result = await self.db.execute(
            select(
                EmotionLog.emotion_type_id,
                func.count(EmotionLog.id).label("count"),
            )
            .where(EmotionLog.user_id == user_id, EmotionLog.logged_at >= since)
            .group_by(EmotionLog.emotion_type_id)
            .order_by(func.count(EmotionLog.id).desc())
        )
        rows = result.all()
        if not rows:
            return []

        total = sum(r.count for r in rows)
        type_ids = [r.emotion_type_id for r in rows]
        types_result = await self.db.execute(
            select(EmotionType).where(EmotionType.id.in_(type_ids))
        )
        types_map = {et.id: et for et in types_result.scalars().all()}

        return [
            {
                "emotion_type": types_map[r.emotion_type_id],
                "count": r.count,
                "percentage": round(r.count / total * 100, 1),
            }
            for r in rows
            if r.emotion_type_id in types_map
        ]

    async def avg_intensity(self, user_id: UUID, week_start: date) -> Optional[float]:
        week_end = date.fromordinal(week_start.toordinal() + 6)
        result = await self.db.execute(
            select(func.avg(EmotionLog.intensity)).where(
                EmotionLog.user_id == user_id,
                cast(EmotionLog.logged_at, Date) >= week_start,
                cast(EmotionLog.logged_at, Date) <= week_end,
            )
        )
        return result.scalar_one_or_none()

    async def get_week_emotion_stats(
        self, user_id: UUID, week_start: date, week_end: date
    ) -> Tuple[Optional[UUID], int]:
        result = await self.db.execute(
            select(
                EmotionLog.emotion_type_id,
                func.count(EmotionLog.id).label("cnt"),
            )
            .where(
                EmotionLog.user_id == user_id,
                cast(EmotionLog.logged_at, Date) >= week_start,
                cast(EmotionLog.logged_at, Date) <= week_end,
            )
            .group_by(EmotionLog.emotion_type_id)
            .order_by(func.count(EmotionLog.id).desc())
        )
        rows = result.all()
        total_logs = sum(r.cnt for r in rows)
        dominant_emotion_id = rows[0].emotion_type_id if rows else None
        return dominant_emotion_id, total_logs

    async def get_habit_completion_pct(
        self, user_id: UUID, week_start: date, week_end: date
    ) -> Optional[float]:
        total_q = await self.db.execute(
            select(func.count(Habit.id)).where(
                Habit.user_id == user_id,
                Habit.is_archived == False,
            )
        )
        total_habits = total_q.scalar_one_or_none() or 0
        if total_habits == 0:
            return None

        done_q = await self.db.execute(
            select(func.count(func.distinct(HabitLog.habit_id))).where(
                HabitLog.user_id == user_id,
                HabitLog.status == "done",
                HabitLog.completed_date >= week_start,
                HabitLog.completed_date <= week_end,
            )
        )
        done_habits = done_q.scalar_one_or_none() or 0
        return round(done_habits / total_habits * 100, 2)

    async def get_emotion_type(self, emotion_type_id: UUID) -> Optional[EmotionType]:
        result = await self.db.execute(
            select(EmotionType).where(EmotionType.id == emotion_type_id)
        )
        return result.scalar_one_or_none()

    async def upsert_weekly_summary(
        self,
        user_id: UUID,
        week_start: date,
        dominant_emotion_id: Optional[UUID],
        avg_intensity: Optional[float],
        total_logs: int,
        habits_completion_pct: Optional[float],
        insight_text: Optional[str] = None,
    ) -> WeeklySummary:
        result = await self.db.execute(
            select(WeeklySummary).where(
                WeeklySummary.user_id == user_id,
                WeeklySummary.week_start == week_start,
            )
        )
        summary = result.scalar_one_or_none()
        if summary:
            summary.dominant_emotion_id = dominant_emotion_id
            summary.avg_intensity = avg_intensity
            summary.total_logs = total_logs
            summary.habits_completion_pct = habits_completion_pct
            summary.insight_text = insight_text
        else:
            summary = WeeklySummary(
                user_id=user_id,
                week_start=week_start,
                dominant_emotion_id=dominant_emotion_id,
                avg_intensity=avg_intensity,
                total_logs=total_logs,
                habits_completion_pct=habits_completion_pct,
                insight_text=insight_text,
            )
            self.db.add(summary)
        await self.db.flush()
        await self.db.refresh(summary)
        return summary

    async def habits_vs_mood(self, user_id: UUID, days: int) -> List[dict]:
        since = func.current_date() - func.make_interval(0, 0, 0, days)

        habit_sub = (
            select(
                HabitLog.completed_date.label("log_date"),
                func.count(HabitLog.id).label("habits_completed"),
            )
            .where(
                HabitLog.user_id == user_id,
                HabitLog.status == "done",
                HabitLog.completed_date >= since,
            )
            .group_by(HabitLog.completed_date)
            .subquery()
        )

        mood_sub = (
            select(
                cast(EmotionLog.logged_at, Date).label("log_date"),
                func.avg(EmotionLog.intensity).label("avg_intensity"),
            )
            .where(
                EmotionLog.user_id == user_id,
                cast(EmotionLog.logged_at, Date) >= since,
            )
            .group_by(cast(EmotionLog.logged_at, Date))
            .subquery()
        )

        result = await self.db.execute(
            select(
                habit_sub.c.log_date,
                habit_sub.c.habits_completed,
                mood_sub.c.avg_intensity,
            )
            .outerjoin(mood_sub, habit_sub.c.log_date == mood_sub.c.log_date)
            .order_by(habit_sub.c.log_date.desc())
        )
        return [
            {
                "date": row.log_date,
                "habits_completed": row.habits_completed,
                "avg_intensity": float(row.avg_intensity) if row.avg_intensity is not None else None,
            }
            for row in result.all()
        ]
