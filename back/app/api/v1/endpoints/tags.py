from typing import List
from uuid import UUID

from fastapi import APIRouter, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_db
from app.dependencies import get_current_user
from app.models.user import User
from app.schemas.tag import TagCreate, TagOut, TagUpdate
from app.services.tag_service import TagService

router = APIRouter()


@router.get("/", response_model=List[TagOut], status_code=status.HTTP_200_OK)
async def list_tags(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> List[TagOut]:
    service = TagService(db)
    return await service.list_tags(current_user)


@router.post("/", response_model=TagOut, status_code=status.HTTP_201_CREATED)
async def create_tag(
    body: TagCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> TagOut:
    service = TagService(db)
    return await service.create_tag(current_user, body)


@router.patch("/{tag_id}", response_model=TagOut, status_code=status.HTTP_200_OK)
async def update_tag(
    tag_id: UUID,
    body: TagUpdate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> TagOut:
    service = TagService(db)
    return await service.update_tag(current_user, tag_id, body)


@router.delete("/{tag_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_tag(
    tag_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
) -> None:
    service = TagService(db)
    await service.delete_tag(current_user, tag_id)
