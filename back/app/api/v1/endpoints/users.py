from fastapi import APIRouter, Depends, status
from pydantic import BaseModel
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db
from app.dependencies import get_current_user
from app.models.user import User
from app.schemas.user import PreferencesOut, PreferencesUpdate, UserProfileOut, UserUpdate
from app.services.user_service import UserService

router = APIRouter()


class DeleteAccountRequest(BaseModel):
    password: str


@router.get("/profile", response_model=UserProfileOut, status_code=status.HTTP_200_OK)
async def get_profile(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> UserProfileOut:
    service = UserService(db)
    return await service.get_profile(current_user.id)


@router.patch("/profile", response_model=UserProfileOut, status_code=status.HTTP_200_OK)
async def update_profile(
    body: UserUpdate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> UserProfileOut:
    service = UserService(db)
    return await service.update_profile(current_user, body)


@router.patch("/preferences", response_model=PreferencesOut, status_code=status.HTTP_200_OK)
async def update_preferences(
    body: PreferencesUpdate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> PreferencesOut:
    service = UserService(db)
    await service.update_preferences(current_user, body)
    updated = await service.get_profile(current_user.id)
    return updated.preferences


@router.delete("/account", status_code=status.HTTP_204_NO_CONTENT)
async def delete_account(
    body: DeleteAccountRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> None:
    service = UserService(db)
    await service.delete_account(current_user, body.password)
