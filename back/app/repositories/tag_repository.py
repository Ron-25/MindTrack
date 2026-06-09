from typing import List, Optional
from uuid import UUID

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.emotion import Tag
from app.repositories.base_repository import BaseRepository


class TagRepository(BaseRepository[Tag]):
    def __init__(self, db: AsyncSession):
        super().__init__(Tag, db)

    async def list_by_user(self, user_id: UUID) -> List[Tag]:
        result = await self.db.execute(
            select(Tag).where(Tag.user_id == user_id).order_by(Tag.name)
        )
        return list(result.scalars().all())

    async def get_by_name(self, user_id: UUID, name: str) -> Optional[Tag]:
        result = await self.db.execute(
            select(Tag).where(Tag.user_id == user_id, Tag.name == name)
        )
        return result.scalar_one_or_none()

    async def get_by_ids(self, tag_ids: List[UUID], user_id: UUID) -> List[Tag]:
        if not tag_ids:
            return []
        result = await self.db.execute(
            select(Tag).where(Tag.id.in_(tag_ids), Tag.user_id == user_id)
        )
        return list(result.scalars().all())
