from pydantic import BaseModel, Field
from uuid import UUID
from typing import Optional


class EmotionTypeOut(BaseModel):
    id: UUID
    name: str
    name_es: Optional[str]
    color_hex: str
    icon: Optional[str]
    category: Optional[str]
    is_system: bool

    model_config = {"from_attributes": True}


class EmotionTypeCreate(BaseModel):
    name: str = Field(min_length=1, max_length=60)
    name_es: Optional[str] = Field(default=None, max_length=60)
    color_hex: str = Field(pattern=r"^#[0-9A-Fa-f]{6}$")
    icon: Optional[str] = None
    category: Optional[str] = None