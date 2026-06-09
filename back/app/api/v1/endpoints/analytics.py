from datetime import date
from typing import List

from fastapi import APIRouter, Depends, Query, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db
from app.dependencies import get_current_user
from app.models.user import User
from app.schemas.analytics import CorrelationPointOut, FrequencyItemOut, WeeklySummaryOut
from app.services.analytics_service import AnalyticsService

router = APIRouter()


@router.get("/weekly-summary", response_model=WeeklySummaryOut, status_code=status.HTTP_200_OK)
async def weekly_summary(
    week_start: date = Query(...),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> WeeklySummaryOut:
    service = AnalyticsService(db)
    return await service.weekly_summary(current_user, week_start)


@router.get("/emotion-frequency", response_model=List[FrequencyItemOut], status_code=status.HTTP_200_OK)
async def emotion_frequency(
    days: int = Query(default=30, ge=1, le=365),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> List[FrequencyItemOut]:
    service = AnalyticsService(db)
    return await service.emotion_frequency(current_user, days)


@router.get("/habits-mood", response_model=List[CorrelationPointOut], status_code=status.HTTP_200_OK)
async def habits_mood(
    days: int = Query(default=30, ge=1, le=365),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> List[CorrelationPointOut]:
    service = AnalyticsService(db)
    return await service.habits_vs_mood(current_user, days)
