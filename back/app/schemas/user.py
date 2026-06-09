from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import time


class UserUpdate(BaseModel):
    name: Optional[str] = Field(default=None, min_length=1, max_length=120)
    avatar_url: Optional[str] = None


class PreferencesUpdate(BaseModel):
    theme: Optional[str] = Field(default=None, pattern=r"^(light|dark|system)$")
    language: Optional[str] = Field(default=None, max_length=5)
    notif_enabled: Optional[bool] = None
    notif_time: Optional[time] = None
    pin_enabled: Optional[bool] = None
    biometric_ok: Optional[bool] = None


class PreferencesOut(BaseModel):
    theme: str
    language: str
    notif_enabled: bool
    notif_time: time
    pin_enabled: bool
    biometric_ok: bool

    model_config = {"from_attributes": True}


class UserProfileOut(BaseModel):
    id: str
    name: str
    email: str
    avatar_url: Optional[str]
    plan_type: str
    preferences: Optional[PreferencesOut]

    model_config = {"from_attributes": True}