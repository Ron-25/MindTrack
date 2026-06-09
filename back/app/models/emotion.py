from sqlalchemy import Column, String, Boolean, SmallInteger, Text, Table, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
import uuid

from app.models.base import Base, TimestampMixin


emotion_log_tags = Table(
    "emotion_log_tags",
    Base.metadata,
    Column("emotion_log_id", UUID(as_uuid=True), ForeignKey("mindtrack.emotion_logs.id", ondelete="CASCADE"), primary_key=True),
    Column("tag_id", UUID(as_uuid=True), ForeignKey("mindtrack.tags.id", ondelete="CASCADE"), primary_key=True),
    schema="mindtrack",
)


class EmotionType(Base):
    __tablename__ = "emotion_types"
    __table_args__ = {"schema": "mindtrack"}

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("mindtrack.users.id", ondelete="CASCADE"), nullable=True)
    name = Column(String(60), nullable=False)
    name_es = Column(String(60))
    color_hex = Column(String(7), nullable=False)
    icon = Column(String(50))
    category = Column(String(40))
    is_system = Column(Boolean, nullable=False, default=False)
    created_at = Column(__import__("sqlalchemy").DateTime(timezone=True), server_default=__import__("sqlalchemy").func.now(), nullable=False)

    logs = relationship("EmotionLog", back_populates="emotion_type")


class EmotionLog(Base, TimestampMixin):
    __tablename__ = "emotion_logs"
    __table_args__ = {"schema": "mindtrack"}

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("mindtrack.users.id", ondelete="CASCADE"), nullable=False)
    emotion_type_id = Column(UUID(as_uuid=True), ForeignKey("mindtrack.emotion_types.id"), nullable=False)
    intensity = Column(SmallInteger, nullable=False)
    note = Column(Text)
    context_place = Column(String(80))
    context_activity = Column(String(80))
    context_people = Column(String(80))
    logged_at = Column(__import__("sqlalchemy").DateTime(timezone=True), nullable=False)

    user = relationship("User", back_populates="emotion_logs")
    emotion_type = relationship("EmotionType", back_populates="logs")
    tags = relationship("Tag", secondary=emotion_log_tags, back_populates="emotion_logs")


class Tag(Base):
    __tablename__ = "tags"
    __table_args__ = {"schema": "mindtrack"}

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("mindtrack.users.id", ondelete="CASCADE"), nullable=False)
    name = Column(String(40), nullable=False)
    color_hex = Column(String(7))
    created_at = Column(__import__("sqlalchemy").DateTime(timezone=True), server_default=__import__("sqlalchemy").func.now(), nullable=False)

    emotion_logs = relationship("EmotionLog", secondary=emotion_log_tags, back_populates="tags")