from pydantic import BaseModel, Field
from uuid import UUID
from typing import Optional


class TagCreate(BaseModel):
    name: str = Field(min_length=1, max_length=40)
    color_hex: Optional[str] = Field(default=None, pattern=r"^#[0-9A-Fa-f]{6}$")


class TagUpdate(BaseModel):
    name: Optional[str] = Field(default=None, min_length=1, max_length=40)
    color_hex: Optional[str] = Field(default=None, pattern=r"^#[0-9A-Fa-f]{6}$")


class TagOut(BaseModel):
    id: UUID
    name: str
    color_hex: Optional[str]

    model_config = {"from_attributes": True}