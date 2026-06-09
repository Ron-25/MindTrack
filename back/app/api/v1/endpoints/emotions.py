from datetime import datetime
from typing import List, Optional
from uuid import UUID

from fastapi import APIRouter, Depends, Query, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db
from app.dependencies import get_current_user
from app.models.user import User
from app.schemas.emotion import EmotionLogCreate, EmotionLogOut, EmotionLogUpdate
from app.services.emotion_service import EmotionService

router = APIRouter()


@router.get("/", response_model=List[EmotionLogOut], status_code=status.HTTP_200_OK)
async def list_emotions(
    start_date: Optional[datetime] = Query(default=None),
    end_date: Optional[datetime] = Query(default=None),
    emotion_type_id: Optional[UUID] = Query(default=None),
    min_intensity: Optional[int] = Query(default=None, ge=1, le=10),
    max_intensity: Optional[int] = Query(default=None, ge=1, le=10),
    q: Optional[str] = Query(default=None, max_length=200),
    limit: int = Query(default=20, ge=1, le=100),
    offset: int = Query(default=0, ge=0),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> List[EmotionLogOut]:
    service = EmotionService(db)
    return await service.list_logs(
        current_user, start_date, end_date, emotion_type_id,
        min_intensity, max_intensity, q, limit, offset,
    )


@router.post("/", response_model=EmotionLogOut, status_code=status.HTTP_201_CREATED)
async def create_emotion(
    body: EmotionLogCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> EmotionLogOut:
    service = EmotionService(db)
    return await service.create_log(current_user, body)


@router.get("/{log_id}", response_model=EmotionLogOut, status_code=status.HTTP_200_OK)
async def get_emotion(
    log_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> EmotionLogOut:
    service = EmotionService(db)
    return await service.get_log(current_user, log_id)


@router.patch("/{log_id}", response_model=EmotionLogOut, status_code=status.HTTP_200_OK)
async def update_emotion(
    log_id: UUID,
    body: EmotionLogUpdate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> EmotionLogOut:
    service = EmotionService(db)
    return await service.update_log(current_user, log_id, body)


@router.delete("/{log_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_emotion(
    log_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> None:
    service = EmotionService(db)
    await service.delete_log(current_user, log_id)
