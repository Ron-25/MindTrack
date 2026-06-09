from datetime import date
from typing import List, Optional
from uuid import UUID

from sqlalchemy.ext.asyncio import AsyncSession

from app.core.exceptions import BadRequestError, ForbiddenError, NotFoundError
from app.models.habit import Habit, HabitLog
from app.models.user import User
from app.repositories.habit_log_repository import HabitLogRepository
from app.repositories.habit_repository import HabitRepository
from app.schemas.habit import HabitCreate, HabitLogOut, HabitOut, HabitProgressOut, HabitUpdate


class HabitService:
    def __init__(self, db: AsyncSession):
        self.repo = HabitRepository(db)
        self.log_repo = HabitLogRepository(db)

    async def create_habit(self, user: User, data: HabitCreate) -> Habit:
        habit = Habit(
            user_id=user.id,
            name=data.name,
            description=data.description,
            icon=data.icon,
            color_hex=data.color_hex,
            category=data.category,
            target_days_week=data.target_days_week,
        )
        return await self.repo.save(habit)

    async def list_habits(self, user: User, include_archived: bool = False) -> List[Habit]:
        if include_archived:
            return await self.repo.list_all_by_user(user.id)
        return await self.repo.list_active_by_user(user.id)

    async def get_habit(self, user: User, habit_id: UUID) -> Habit:
        habit = await self.repo.get_by_id(habit_id)
        if not habit:
            raise NotFoundError("Hábito no encontrado")
        if habit.user_id != user.id:
            raise ForbiddenError()
        return habit

    async def update_habit(self, user: User, habit_id: UUID, data: HabitUpdate) -> Habit:
        habit = await self.get_habit(user, habit_id)
        for field, value in data.model_dump(exclude_none=True).items():
            setattr(habit, field, value)
        return await self.repo.save(habit)

    async def archive_habit(self, user: User, habit_id: UUID) -> Habit:
        habit = await self.get_habit(user, habit_id)
        return await self.repo.archive(habit)

    async def delete_habit(self, user: User, habit_id: UUID) -> None:
        habit = await self.get_habit(user, habit_id)
        if await self.log_repo.has_any_logs(habit_id):
            raise BadRequestError("No se puede eliminar un hábito con registros")
        await self.repo.delete(habit)

    async def log_habit(
        self, user: User, habit_id: UUID, completed_date: date, status: str, note: Optional[str]
    ) -> HabitLog:
        habit = await self.get_habit(user, habit_id)
        return await self.log_repo.upsert_log(habit.id, user.id, completed_date, status, note)

    async def get_progress(self, user: User, habit_id: UUID, week_start: date) -> HabitProgressOut:
        habit = await self.get_habit(user, habit_id)
        logs = await self.log_repo.get_week_logs(habit_id, week_start)
        completed_days = sum(1 for log in logs if log.status == "done")
        target_days = habit.target_days_week
        completion_pct = (completed_days / target_days * 100) if target_days > 0 else 0.0
        return HabitProgressOut(
            habit=HabitOut.model_validate(habit),
            week_start=week_start,
            target_days=target_days,
            completed_days=completed_days,
            completion_pct=round(completion_pct, 1),
            logs=[HabitLogOut.model_validate(l) for l in logs],
        )
