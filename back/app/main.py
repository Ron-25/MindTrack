from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager

from app.config import settings
from app.api.v1.router import api_router


@asynccontextmanager
async def lifespan(app: FastAPI):
    print(f"MindTrack API iniciando en modo {settings.environment}...")
    yield
    print("MindTrack API cerrando...")


app = FastAPI(
    title=settings.app_name,
    version=settings.version,
    description="Backend de MindTrack",
    docs_url="/docs",
    redoc_url="/redoc",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.allowed_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(api_router)
@app.get("/", tags=["Health"])
async def health_check():
    return {
        "status": "ok",
        "app": settings.app_name,
        "version": settings.version,
        "environment": settings.environment,
    }