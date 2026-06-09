from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from sqlalchemy.orm import selectinload
from typing import List
from uuid import UUID

from app.models.habit import Habit, HabitLog
from app.repositories.base_repository import BaseRepository


class HabitRepository(BaseRepository[Habit]):
    def __init__(self, db: AsyncSession):
        super().__init__(Habit, db)

    async def list_active_by_user(self, user_id: UUID) -> List[Habit]:
        result = await self.db.execute(
            select(Habit)
            .where(Habit.user_id == user_id, Habit.is_archived == False)
            .order_by(Habit.created_at.desc())
        )
        return result.scalars().all()

    async def list_all_by_user(self, user_id: UUID) -> List[Habit]:
        result = await self.db.execute(
            select(Habit)
            .where(Habit.user_id == user_id)
            .order_by(Habit.created_at.desc())
        )
        return result.scalars().all()

    async def archive(self, habit: Habit) -> Habit:
        habit.is_archived = True
        await self.db.flush()
        return habit