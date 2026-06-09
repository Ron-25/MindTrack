from typing import List

from sqlalchemy.ext.asyncio import AsyncSession

from app.models.emotion import EmotionType
from app.models.user import User
from app.repositories.emotion_repository import EmotionRepository
from app.schemas.emotion_type import EmotionTypeCreate


class EmotionTypeService:
    def __init__(self, db: AsyncSession):
        self.repo = EmotionRepository(db)

    async def list_emotion_types(self, user: User) -> List[EmotionType]:
        return await self.repo.get_emotion_types(user.id)

    async def create_emotion_type(self, user: User, data: EmotionTypeCreate) -> EmotionType:
        emotion_type = EmotionType(
            user_id=user.id,
            name=data.name,
            name_es=data.name_es,
            color_hex=data.color_hex,
            icon=data.icon,
            category=data.category,
            is_system=False,
        )
        self.repo.db.add(emotion_type)
        await self.repo.db.flush()
        await self.repo.db.refresh(emotion_type)
        return emotion_type
