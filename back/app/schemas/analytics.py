from pydantic import BaseModel
from uuid import UUID
from datetime import date
from typing import Optional, List
from app.schemas.emotion_type import EmotionTypeOut


class WeeklySummaryOut(BaseModel):
    id: UUID
    week_start: date
    dominant_emotion: Optional[EmotionTypeOut]
    avg_intensity: Optional[float]
    total_logs: int
    habits_completion_pct: Optional[float]
    insight_text: Optional[str]

    model_config = {"from_attributes": True}


class FrequencyItemOut(BaseModel):
    emotion_type: EmotionTypeOut
    count: int
    percentage: float


class CorrelationPointOut(BaseModel):
    date: date
    habits_completed: int
    avg_intensity: Optional[float]