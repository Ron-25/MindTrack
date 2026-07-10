from pydantic import BaseModel, Field
from uuid import UUID
from datetime import datetime
from typing import Optional, List
from app.schemas.tag import TagOut
from app.schemas.emotion_type import EmotionTypeOut


class EmotionLogCreate(BaseModel):
    emotion_type_id: UUID
    intensity: int = Field(ge=1, le=10)
    note: Optional[str] = None
    context_place: Optional[str] = Field(default=None, max_length=80)
    context_activity: Optional[str] = Field(default=None, max_length=80)
    context_people: Optional[str] = Field(default=None, max_length=80)
    tag_ids: Optional[List[UUID]] = []
    logged_at: datetime


class EmotionLogUpdate(BaseModel):
    intensity: Optional[int] = Field(default=None, ge=1, le=10)
    note: Optional[str] = None
    tag_ids: Optional[List[UUID]] = None


class EmotionLogOut(BaseModel):
    id: UUID
    emotion_type: EmotionTypeOut
    intensity: int
    note: Optional[str]
    context_place: Optional[str]
    context_activity: Optional[str]
    context_people: Optional[str]
    tags: List[TagOut]
    logged_at: datetime
    created_at: datetime

    model_config = {"from_attributes": True}


class EmotionStreakOut(BaseModel):
    current_streak: int
    longest_streak: int
    logged_today: bool
