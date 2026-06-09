from sqlalchemy import Column, String, Boolean, SmallInteger, Text, Date, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
import uuid

from app.models.base import Base, TimestampMixin


class Habit(Base, TimestampMixin):
    __tablename__ = "habits"
    __table_args__ = {"schema": "mindtrack"}

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("mindtrack.users.id", ondelete="CASCADE"), nullable=False)
    name = Column(String(120), nullable=False)
    description = Column(Text)
    icon = Column(String(50))
    color_hex = Column(String(7))
    category = Column(String(40))
    target_days_week = Column(SmallInteger, nullable=False)
    is_archived = Column(Boolean, nullable=False, default=False)

    user = relationship("User", back_populates="habits")
    logs = relationship("HabitLog", back_populates="habit")


class HabitLog(Base):
    __tablename__ = "habit_logs"
    __table_args__ = {"schema": "mindtrack"}

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    habit_id = Column(UUID(as_uuid=True), ForeignKey("mindtrack.habits.id", ondelete="CASCADE"), nullable=False)
    user_id = Column(UUID(as_uuid=True), ForeignKey("mindtrack.users.id", ondelete="CASCADE"), nullable=False)
    completed_date = Column(Date, nullable=False)
    status = Column(String(10), nullable=False, default="done")
    note = Column(Text)
    created_at = Column(__import__("sqlalchemy").DateTime(timezone=True), server_default=__import__("sqlalchemy").func.now(), nullable=False)

    habit = relationship("Habit", back_populates="logs")