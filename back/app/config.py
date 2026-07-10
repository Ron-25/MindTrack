from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import AnyUrl
from typing import List
import json

class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
    )

    # App
    app_name: str = "MindTrack API"
    version: str = "1.0.0"
    debug: bool = False
    environment: str = "development"  # development | staging | production

    # Base de datos
    database_url: str
    db_pool_size: int = 10
    db_max_overflow: int = 20

    # JWT
    secret_key: str
    algorithm: str = "HS256"
    access_token_expire_minutes: int = 30
    refresh_token_expire_days: int = 30

    redis_url: str = "redis://localhost:6379/0"

    allowed_origins: List[str] = ["http://localhost:3000"]

    celery_broker_url: str = "redis://localhost:6379/1"
    celery_result_backend: str = "redis://localhost:6379/2"

    gemini_api_key: str = ""
    gemini_model: str = "gemini-2.0-flash"


settings = Settings()