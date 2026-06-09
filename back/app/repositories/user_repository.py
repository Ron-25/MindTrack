from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from sqlalchemy.orm import selectinload
from typing import Optional
from uuid import UUID

from app.models.user import User, UserPreferences
from app.repositories.base_repository import BaseRepository


class UserRepository(BaseRepository[User]):
    def __init__(self, db: AsyncSession):
        super().__init__(User, db)

    async def get_by_email(self, email: str) -> Optional[User]:
        result = await self.db.execute(
            select(User).where(User.email == email)
        )
        return result.scalar_one_or_none()

    async def create_with_preferences(self, user: User) -> User:
        self.db.add(user)
        await self.db.flush()
        prefs = UserPreferences(user_id=user.id)
        self.db.add(prefs)
        await self.db.flush()
        await self.db.refresh(user)
        return user

    async def get_with_preferences(self, user_id: UUID) -> Optional[User]:
        result = await self.db.execute(
            select(User).where(User.id == user_id).options(selectinload(User.preferences))
        )
        return result.scalar_one_or_none()

    async def soft_delete(self, user: User) -> None:
        user.is_active = False
        await self.db.flush()