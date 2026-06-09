from sqlalchemy import Column, String, Boolean, Time, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
from datetime import time
import uuid

from app.models.base import Base, TimestampMixin


class User(Base, TimestampMixin):
    __tablename__ = "users"
    __table_args__ = {"schema": "mindtrack"}

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = Column(String(120), nullable=False)
    email = Column(String(255), nullable=False, unique=True)
    password_hash = Column(String(255), nullable=False)
    avatar_url = Column(String)
    plan_type = Column(String(20), nullable=False, default="free")
    is_active = Column(Boolean, nullable=False, default=True)

    preferences = relationship("UserPreferences", back_populates="user", uselist=False)
    refresh_tokens = relationship("RefreshToken", back_populates="user")
    emotion_logs = relationship("EmotionLog", back_populates="user")
    habits = relationship("Habit", back_populates="user")


class UserPreferences(Base):
    __tablename__ = "user_preferences"
    __table_args__ = {"schema": "mindtrack"}

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("mindtrack.users.id", ondelete="CASCADE"), nullable=False, unique=True)
    theme = Column(String(10), nullable=False, default="system")
    language = Column(String(5), nullable=False, default="es")
    notif_enabled = Column(Boolean, nullable=False, default=True)
    notif_time = Column(Time, nullable=False, default=time(20, 0))
    pin_enabled = Column(Boolean, nullable=False, default=False)
    biometric_ok = Column(Boolean, nullable=False, default=False)
    updated_at = Column(__import__("sqlalchemy").DateTime(timezone=True), onupdate=__import__("sqlalchemy").func.now())

    user = relationship("User", back_populates="preferences")


class RefreshToken(Base):
    __tablename__ = "refresh_tokens"
    __table_args__ = {"schema": "mindtrack"}

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("mindtrack.users.id", ondelete="CASCADE"), nullable=False)
    token_hash = Column(String(255), nullable=False)
    device_info = Column(String(120))
    expires_at = Column(__import__("sqlalchemy").DateTime(timezone=True), nullable=False)
    revoked = Column(Boolean, nullable=False, default=False)
    created_at = Column(__import__("sqlalchemy").DateTime(timezone=True), server_default=__import__("sqlalchemy").func.now(), nullable=False)

    user = relationship("User", back_populates="refresh_tokens")