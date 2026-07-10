from fastapi import APIRouter, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db
from app.dependencies import get_current_user
from app.models.user import User
from app.schemas.coach import CoachChatIn, CoachChatOut, CoachInsightsOut
from app.services.coach_service import CoachService

router = APIRouter()


@router.get("/insights", response_model=CoachInsightsOut, status_code=status.HTTP_200_OK)
async def get_coach_insights(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> CoachInsightsOut:
    service = CoachService(db)
    return await service.get_insights(current_user)


@router.post("/chat", response_model=CoachChatOut, status_code=status.HTTP_200_OK)
async def chat_with_coach(
    body: CoachChatIn,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> CoachChatOut:
    service = CoachService(db)
    return await service.chat(current_user, body)
