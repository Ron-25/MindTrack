from datetime import datetime
from typing import List, Optional
from uuid import UUID

from sqlalchemy import and_, cast, Date, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.emotion import EmotionLog, EmotionType, Tag
from app.repositories.base_repository import BaseRepository


class EmotionRepository(BaseRepository[EmotionLog]):
    def __init__(self, db: AsyncSession):
        super().__init__(EmotionLog, db)

    async def list_with_filters(
        self,
        user_id: UUID,
        start_date: Optional[datetime] = None,
        end_date: Optional[datetime] = None,
        emotion_type_id: Optional[UUID] = None,
        min_intensity: Optional[int] = None,
        max_intensity: Optional[int] = None,
        q: Optional[str] = None,
        limit: int = 20,
        offset: int = 0,
    ) -> List[EmotionLog]:
        filters = [EmotionLog.user_id == user_id]
        if start_date:
            filters.append(EmotionLog.logged_at >= start_date)
        if end_date:
            filters.append(EmotionLog.logged_at <= end_date)
        if emotion_type_id:
            filters.append(EmotionLog.emotion_type_id == emotion_type_id)
        if min_intensity is not None:
            filters.append(EmotionLog.intensity >= min_intensity)
        if max_intensity is not None:
            filters.append(EmotionLog.intensity <= max_intensity)
        if q:
            filters.append(EmotionLog.note.ilike(f"%{q}%"))

        result = await self.db.execute(
            select(EmotionLog)
            .where(and_(*filters))
            .options(selectinload(EmotionLog.emotion_type), selectinload(EmotionLog.tags))
            .order_by(EmotionLog.logged_at.desc())
            .limit(limit)
            .offset(offset)
        )
        return list(result.scalars().all())

    async def list_by_user(self, user_id: UUID, limit: int = 20, offset: int = 0) -> List[EmotionLog]:
        result = await self.db.execute(
            select(EmotionLog)
            .where(EmotionLog.user_id == user_id)
            .options(selectinload(EmotionLog.emotion_type), selectinload(EmotionLog.tags))
            .order_by(EmotionLog.logged_at.desc())
            .limit(limit)
            .offset(offset)
        )
        return list(result.scalars().all())

    async def get_with_tags(self, log_id: UUID) -> Optional[EmotionLog]:
        result = await self.db.execute(
            select(EmotionLog)
            .where(EmotionLog.id == log_id)
            .options(selectinload(EmotionLog.emotion_type), selectinload(EmotionLog.tags))
        )
        return result.scalar_one_or_none()

    async def get_emotion_types(self, user_id: UUID) -> List[EmotionType]:
        result = await self.db.execute(
            select(EmotionType)
            .where((EmotionType.user_id == None) | (EmotionType.user_id == user_id))
            .order_by(EmotionType.name)
        )
        return list(result.scalars().all())

    async def get_emotion_type_by_id(self, emotion_type_id: UUID) -> Optional[EmotionType]:
        result = await self.db.execute(
            select(EmotionType).where(EmotionType.id == emotion_type_id)
        )
        return result.scalar_one_or_none()

    async def create_with_tags(self, log: EmotionLog, tag_ids: List[UUID], user_id: UUID) -> EmotionLog:
        self.db.add(log)
        await self.db.flush()
        if tag_ids:
            tags_result = await self.db.execute(
                select(Tag).where(Tag.id.in_(tag_ids), Tag.user_id == user_id)
            )
            log.tags = list(tags_result.scalars().all())
            await self.db.flush()
        result = await self.db.execute(
            select(EmotionLog)
            .where(EmotionLog.id == log.id)
            .options(selectinload(EmotionLog.emotion_type), selectinload(EmotionLog.tags))
        )
        return result.scalar_one()

    async def update_tags(self, log: EmotionLog, tag_ids: List[UUID], user_id: UUID) -> EmotionLog:
        tags_result = await self.db.execute(
            select(Tag).where(Tag.id.in_(tag_ids), Tag.user_id == user_id)
        )
        log.tags = list(tags_result.scalars().all())
        await self.db.flush()
        result = await self.db.execute(
            select(EmotionLog)
            .where(EmotionLog.id == log.id)
            .options(selectinload(EmotionLog.emotion_type), selectinload(EmotionLog.tags))
        )
        return result.scalar_one()
