from datetime import datetime, timezone, timedelta
from sqlalchemy.ext.asyncio import AsyncSession

from app.repositories.user_repository import UserRepository
from app.repositories.token_repository import TokenRepository
from app.core.security import hash_password, verify_password, create_access_token, create_refresh_token
from app.core.exceptions import UnauthorizedError, ConflictError
from app.models.user import User, RefreshToken
from app.schemas.auth import RegisterRequest, LoginRequest, TokenResponse, RefreshRequest
from app.config import settings


class AuthService:
    def __init__(self, db: AsyncSession):
        self.user_repo = UserRepository(db)
        self.token_repo = TokenRepository(db)

    async def _save_refresh_token(self, user: User, raw_token: str) -> None:
        record = RefreshToken(
            user_id=user.id,
            token_hash=hash_password(raw_token),
            expires_at=datetime.now(timezone.utc) + timedelta(days=settings.refresh_token_expire_days),
        )
        self.token_repo.db.add(record)

    async def register(self, data: RegisterRequest) -> TokenResponse:
        existing = await self.user_repo.get_by_email(data.email)
        if existing:
            raise ConflictError("El email ya está registrado")

        user = User(
            name=data.name,
            email=data.email,
            password_hash=hash_password(data.password),
        )
        user = await self.user_repo.create_with_preferences(user)

        raw_refresh = create_refresh_token(str(user.id))
        await self._save_refresh_token(user, raw_refresh)

        return TokenResponse(
            access_token=create_access_token(str(user.id)),
            refresh_token=raw_refresh,
        )

    async def login(self, data: LoginRequest) -> TokenResponse:
        user = await self.user_repo.get_by_email(data.email)
        if not user or not verify_password(data.password, user.password_hash):
            raise UnauthorizedError("Credenciales incorrectas")

        if not user.is_active:
            raise UnauthorizedError("Cuenta desactivada")

        raw_refresh = create_refresh_token(str(user.id))
        await self._save_refresh_token(user, raw_refresh)

        return TokenResponse(
            access_token=create_access_token(str(user.id)),
            refresh_token=raw_refresh,
        )

    async def logout(self, data: RefreshRequest) -> None:
        token_record = await self.token_repo.get_valid_token(hash_password(data.refresh_token))
        if not token_record:
            raise UnauthorizedError("Token inválido o ya revocado")
        await self.token_repo.revoke(token_record)

    async def refresh_token(self, data: RefreshRequest) -> TokenResponse:
        token_record = await self.token_repo.get_valid_token(hash_password(data.refresh_token))
        if not token_record:
            raise UnauthorizedError("Token inválido o expirado")

        # Revocar el token usado (rotación)
        await self.token_repo.revoke(token_record)

        user = await self.user_repo.get_by_id(token_record.user_id)
        if not user or not user.is_active:
            raise UnauthorizedError("Usuario no encontrado o inactivo")

        new_raw_refresh = create_refresh_token(str(user.id))
        await self._save_refresh_token(user, new_raw_refresh)

        return TokenResponse(
            access_token=create_access_token(str(user.id)),
            refresh_token=new_raw_refresh,
        )

    async def forgot_password(self, email: str) -> None:
        """Solicitud de restablecimiento de contraseña.

        Siempre termina sin error, exista o no el correo, para no revelar
        qué cuentas están registradas.
        """
        user = await self.user_repo.get_by_email(email)
        if user is None or not user.is_active:
            return
        # TODO: generar un token de restablecimiento y enviarlo por correo
        # cuando haya un servicio de email configurado (SMTP/SendGrid).
        return
