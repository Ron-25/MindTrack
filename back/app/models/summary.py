from sqlalchemy import Column, String, Boolean, Integer, Numeric, Date, Time, Text, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
import uuid

from app.models.base import Base


class WeeklySummary(Base):
    __tablename__ = "weekly_summaries"
    __table_args__ = {"schema": "mindtrack"}

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("mindtrack.users.id", ondelete="CASCADE"), nullable=False)
    week_start = Column(Date, nullable=False)
    dominant_emotion_id = Column(UUID(as_uuid=True), ForeignKey("mindtrack.emotion_types.id", ondelete="SET NULL"), nullable=True)
    avg_intensity = Column(Numeric(4, 2))
    total_logs = Column(Integer, nullable=False, default=0)
    habits_completion_pct = Column(Numeric(5, 2))
    insight_text = Column(Text)
    generated_at = Column(__import__("sqlalchemy").DateTime(timezone=True), server_default=__import__("sqlalchemy").func.now(), nullable=False)


class Notification(Base):
    __tablename__ = "notifications"
    __table_args__ = {"schema": "mindtrack"}

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("mindtrack.users.id", ondelete="CASCADE"), nullable=False)
    type = Column(String(30), nullable=False)
    scheduled_time = Column(Time)
    habit_id = Column(UUID(as_uuid=True), ForeignKey("mindtrack.habits.id", ondelete="CASCADE"), nullable=True)
    is_active = Column(Boolean, nullable=False, default=True)
    last_triggered = Column(__import__("sqlalchemy").DateTime(timezone=True))
    created_at = Column(__import__("sqlalchemy").DateTime(timezone=True), server_default=__import__("sqlalchemy").func.now(), nullable=False)