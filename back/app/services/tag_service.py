from typing import List
from uuid import UUID

from sqlalchemy.ext.asyncio import AsyncSession

from app.core.exceptions import ConflictError, ForbiddenError, NotFoundError
from app.models.emotion import Tag
from app.models.user import User
from app.repositories.tag_repository import TagRepository
from app.schemas.tag import TagCreate, TagUpdate


class TagService:
    def __init__(self, db: AsyncSession):
        self.repo = TagRepository(db)

    async def list_tags(self, user: User) -> List[Tag]:
        return await self.repo.list_by_user(user.id)

    async def create_tag(self, user: User, data: TagCreate) -> Tag:
        existing = await self.repo.get_by_name(user.id, data.name)
        if existing:
            raise ConflictError("Ya existe una etiqueta con ese nombre")
        tag = Tag(user_id=user.id, name=data.name, color_hex=data.color_hex)
        return await self.repo.save(tag)

    async def update_tag(self, user: User, tag_id: UUID, data: TagUpdate) -> Tag:
        tag = await self.repo.get_by_id(tag_id)
        if not tag:
            raise NotFoundError("Etiqueta no encontrada")
        if tag.user_id != user.id:
            raise ForbiddenError()
        for field, value in data.model_dump(exclude_none=True).items():
            setattr(tag, field, value)
        return await self.repo.save(tag)

    async def delete_tag(self, user: User, tag_id: UUID) -> None:
        tag = await self.repo.get_by_id(tag_id)
        if not tag:
            raise NotFoundError("Etiqueta no encontrada")
        if tag.user_id != user.id:
            raise ForbiddenError()
        await self.repo.delete(tag)
