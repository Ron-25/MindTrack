from fastapi import Depends, Header
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from sqlalchemy.ext.asyncio import AsyncSession
from typing import Optional
from uuid import UUID

from app.core.database import get_db
from app.core.security import decode_token
from app.core.exceptions import UnauthorizedError
from app.models.user import User
from app.repositories.base_repository import BaseRepository

security = HTTPBearer()


async def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(security),
    db: AsyncSession = Depends(get_db),
) -> User:
    token = credentials.credentials
    payload = decode_token(token)

    if not payload or payload.get("type") != "access":
        raise UnauthorizedError("Token inválido o expirado")

    user_id = payload.get("sub")
    if not user_id:
        raise UnauthorizedError("Token inválido")

    repo = BaseRepository(User, db)
    user = await repo.get_by_id(UUID(user_id))

    if not user:
        raise UnauthorizedError("Usuario no encontrado")

    if not user.is_active:
        raise UnauthorizedError("Cuenta desactivada")

    return user


async def get_current_admin(
    current_user: User = Depends(get_current_user),
) -> User:
    if current_user.plan_type != "pro":
        raise UnauthorizedError("Sin permisos suficientes")
    return current_user