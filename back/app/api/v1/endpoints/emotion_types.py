from typing import List

from fastapi import APIRouter, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db
from app.dependencies import get_current_user
from app.models.user import User
from app.schemas.emotion_type import EmotionTypeCreate, EmotionTypeOut
from app.services.emotion_type_service import EmotionTypeService

router = APIRouter()


@router.get("/", response_model=List[EmotionTypeOut], status_code=status.HTTP_200_OK)
async def list_emotion_types(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> List[EmotionTypeOut]:
    service = EmotionTypeService(db)
    return await service.list_emotion_types(current_user)


@router.post("/", response_model=EmotionTypeOut, status_code=status.HTTP_201_CREATED)
async def create_emotion_type(
    body: EmotionTypeCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> EmotionTypeOut:
    service = EmotionTypeService(db)
    return await service.create_emotion_type(current_user, body)
