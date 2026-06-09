from sqlalchemy.ext.asyncio import AsyncSession

from app.core.exceptions import ConflictError, NotFoundError, UnauthorizedError
from app.core.security import verify_password
from app.models.user import User
from app.repositories.user_repository import UserRepository
from app.schemas.user import UserUpdate, PreferencesUpdate


class UserService:
    def __init__(self, db: AsyncSession):
        self.repo = UserRepository(db)

    async def get_profile(self, user_id) -> User:
        user = await self.repo.get_with_preferences(user_id)
        if not user:
            raise NotFoundError("Usuario no encontrado")
        return user

    async def update_profile(self, user: User, data: UserUpdate) -> User:
        for field, value in data.model_dump(exclude_none=True).items():
            setattr(user, field, value)
        await self.repo.save(user)
        return await self.repo.get_with_preferences(user.id)

    async def update_preferences(self, user: User, data: PreferencesUpdate) -> None:
        user_with_prefs = await self.repo.get_with_preferences(user.id)
        prefs = user_with_prefs.preferences
        for field, value in data.model_dump(exclude_none=True).items():
            setattr(prefs, field, value)
        await self.repo.db.flush()

    async def delete_account(self, user: User, password: str) -> None:
        if not verify_password(password, user.password_hash):
            raise UnauthorizedError("Contraseña incorrecta")
        await self.repo.soft_delete(user)
