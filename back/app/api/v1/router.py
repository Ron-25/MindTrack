from fastapi import APIRouter

from app.api.v1.endpoints import (
    auth,
    coach,
    emotions,
    emotion_types,
    tags,
    habits,
    analytics,
    users,
)

api_router = APIRouter(prefix="/api/v1")

api_router.include_router(auth.router,          prefix="/auth",           tags=["Auth"])
api_router.include_router(emotions.router,       prefix="/emotions",       tags=["Emotions"])
api_router.include_router(emotion_types.router,  prefix="/emotion-types",  tags=["Emotion Types"])
api_router.include_router(tags.router,           prefix="/tags",           tags=["Tags"])
api_router.include_router(habits.router,         prefix="/habits",         tags=["Habits"])
api_router.include_router(analytics.router,      prefix="/analytics",      tags=["Analytics"])
api_router.include_router(users.router,          prefix="/users",          tags=["Users"])
api_router.include_router(coach.router,          prefix="/coach",          tags=["Coach"])
