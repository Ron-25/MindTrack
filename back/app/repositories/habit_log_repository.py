from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from typing import List, Optional
from uuid import UUID
from datetime import date

from app.models.habit import HabitLog
from app.repositories.base_repository import BaseRepository


class HabitLogRepository(BaseRepository[HabitLog]):
    def __init__(self, db: AsyncSession):
        super().__init__(HabitLog, db)

    async def get_by_habit_and_date(self, habit_id: UUID, completed_date: date) -> Optional[HabitLog]:
        result = await self.db.execute(
            select(HabitLog).where(
                HabitLog.habit_id == habit_id,
                HabitLog.completed_date == completed_date
            )
        )
        return result.scalar_one_or_none()

    async def get_week_logs(self, habit_id: UUID, week_start: date) -> List[HabitLog]:
        week_end = date.fromordinal(week_start.toordinal() + 6)
        result = await self.db.execute(
            select(HabitLog).where(
                HabitLog.habit_id == habit_id,
                HabitLog.completed_date >= week_start,
                HabitLog.completed_date <= week_end
            )
        )
        return result.scalars().all()

    async def has_any_logs(self, habit_id: UUID) -> bool:
        result = await self.db.execute(
            select(HabitLog.id).where(HabitLog.habit_id == habit_id).limit(1)
        )
        return result.scalar_one_or_none() is not None

    async def upsert_log(self, habit_id: UUID, user_id: UUID, completed_date: date, status: str, note: Optional[str]) -> HabitLog:
        log = await self.get_by_habit_and_date(habit_id, completed_date)
        if log:
            log.status = status
            log.note = note
            await self.db.flush()
            return log
        log = HabitLog(
            habit_id=habit_id,
            user_id=user_id,
            completed_date=completed_date,
            status=status,
            note=note,
        )
        return await self.save(log)