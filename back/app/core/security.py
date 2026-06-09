from datetime import datetime, timedelta, timezone
from typing import Optional
import jwt
from jwt.exceptions import PyJWTError
from pwdlib import PasswordHash

from app.config import settings


pwd_hash = PasswordHash.recommended()


# ── Passwords ────────────────────────────────────────────────
def hash_password(password: str) -> str:
    return pwd_hash.hash(password)


def verify_password(plain: str, hashed: str) -> bool:
    return pwd_hash.verify(plain, hashed)


# ── JWT ──────────────────────────────────────────────────────

def create_access_token(user_id: str) -> str:
    expire = datetime.now(timezone.utc) + timedelta(
        minutes=settings.access_token_expire_minutes
    )
    payload = {"sub": user_id, "exp": expire, "type": "access"}
    return jwt.encode(payload, settings.secret_key, algorithm=settings.algorithm)


def create_refresh_token(user_id: str) -> str:
    expire = datetime.now(timezone.utc) + timedelta(
        days=settings.refresh_token_expire_days
    )
    payload = {"sub": user_id, "exp": expire, "type": "refresh"}
    return jwt.encode(payload, settings.secret_key, algorithm=settings.algorithm)


def decode_token(token: str) -> Optional[dict]:
    try:
        payload = jwt.decode(token, settings.secret_key, algorithms=[settings.algorithm])
        return payload
    except PyJWTError:
        return None