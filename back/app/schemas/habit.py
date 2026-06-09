from pydantic import BaseModel, Field
from uuid import UUID
from datetime import date
from typing import Optional, List


class HabitCreate(BaseModel):
    name: str = Field(min_length=1, max_length=120)
    description: Optional[str] = None
    icon: Optional[str] = None
    color_hex: Optional[str] = Field(default=None, pattern=r"^#[0-9A-Fa-f]{6}$")
    category: Optional[str] = None
    target_days_week: int = Field(ge=1, le=7)


class HabitUpdate(BaseModel):
    name: Optional[str] = Field(default=None, min_length=1, max_length=120)
    description: Optional[str] = None
    icon: Optional[str] = None
    color_hex: Optional[str] = Field(default=None, pattern=r"^#[0-9A-Fa-f]{6}$")
    category: Optional[str] = None
    target_days_week: Optional[int] = Field(default=None, ge=1, le=7)
    is_archived: Optional[bool] = None


class HabitOut(BaseModel):
    id: UUID
    name: str
    description: Optional[str]
    icon: Optional[str]
    color_hex: Optional[str]
    category: Optional[str]
    target_days_week: int
    is_archived: bool

    model_config = {"from_attributes": True}


class HabitLogCreate(BaseModel):
    completed_date: date
    status: str = Field(default="done", pattern=r"^(done|skipped)$")
    note: Optional[str] = None


class HabitLogOut(BaseModel):
    id: UUID
    completed_date: date
    status: str
    note: Optional[str]

    model_config = {"from_attributes": True}


class HabitProgressOut(BaseModel):
    habit: HabitOut
    week_start: date
    target_days: int
    completed_days: int
    completion_pct: float
    logs: List[HabitLogOut]