from typing import TypeVar, Generic, Type, Optional
from uuid import UUID
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select

from app.models.base import Base


ModelType = TypeVar("ModelType", bound=Base)


class BaseRepository(Generic[ModelType]):

    def __init__(self, model: Type[ModelType], db: AsyncSession):
        self.model = model
        self.db = db

    async def get_by_id(self, id: UUID) -> Optional[ModelType]:
        result = await self.db.execute(
            select(self.model).where(self.model.id == id)
        )
        return result.scalar_one_or_none()

    async def save(self, entity: ModelType) -> ModelType:
        self.db.add(entity)
        await self.db.flush()
        await self.db.refresh(entity)
        return entity

    async def delete(self, entity: ModelType) -> None:
        await self.db.delete(entity)
        await self.db.flush()

    async def exists(self, id: UUID) -> bool:
        result = await self.db.execute(
            select(self.model.id).where(self.model.id == id)
        )
        return result.scalar_one_or_none() is not None