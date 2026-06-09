from datetime import date
from typing import List
from uuid import UUID

from fastapi import APIRouter, Depends, Query, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db
from app.dependencies import get_current_user
from app.models.user import User
from app.schemas.habit import HabitCreate, HabitLogCreate, HabitLogOut, HabitOut, HabitProgressOut, HabitUpdate
from app.services.habit_service import HabitService

router = APIRouter()


@router.get("/", response_model=List[HabitOut], status_code=status.HTTP_200_OK)
async def list_habits(
    include_archived: bool = Query(default=False),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> List[HabitOut]:
    service = HabitService(db)
    return await service.list_habits(current_user, include_archived)


@router.post("/", response_model=HabitOut, status_code=status.HTTP_201_CREATED)
async def create_habit(
    body: HabitCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> HabitOut:
    service = HabitService(db)
    return await service.create_habit(current_user, body)


@router.get("/{habit_id}", response_model=HabitOut, status_code=status.HTTP_200_OK)
async def get_habit(
    habit_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> HabitOut:
    service = HabitService(db)
    return await service.get_habit(current_user, habit_id)


@router.patch("/{habit_id}", response_model=HabitOut, status_code=status.HTTP_200_OK)
async def update_habit(
    habit_id: UUID,
    body: HabitUpdate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> HabitOut:
    service = HabitService(db)
    return await service.update_habit(current_user, habit_id, body)


@router.post("/{habit_id}/archive", response_model=HabitOut, status_code=status.HTTP_200_OK)
async def archive_habit(
    habit_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> HabitOut:
    service = HabitService(db)
    return await service.archive_habit(current_user, habit_id)


@router.delete("/{habit_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_habit(
    habit_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> None:
    service = HabitService(db)
    await service.delete_habit(current_user, habit_id)


@router.post("/{habit_id}/logs", response_model=HabitLogOut, status_code=status.HTTP_200_OK)
async def log_habit(
    habit_id: UUID,
    body: HabitLogCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> HabitLogOut:
    service = HabitService(db)
    return await service.log_habit(
        current_user, habit_id, body.completed_date, body.status, body.note
    )


@router.get("/{habit_id}/progress", response_model=HabitProgressOut, status_code=status.HTTP_200_OK)
async def get_progress(
    habit_id: UUID,
    week_start: date = Query(...),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> HabitProgressOut:
    service = HabitService(db)
    return await service.get_progress(current_user, habit_id, week_start)
