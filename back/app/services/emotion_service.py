from datetime import date, datetime, timedelta
from typing import List, Optional
from uuid import UUID

from sqlalchemy.ext.asyncio import AsyncSession

from app.core.exceptions import BadRequestError, ForbiddenError, NotFoundError
from app.models.emotion import EmotionLog
from app.models.user import User
from app.repositories.emotion_repository import EmotionRepository
from app.schemas.emotion import EmotionLogCreate, EmotionLogUpdate, EmotionStreakOut


class EmotionService:
    def __init__(self, db: AsyncSession):
        self.repo = EmotionRepository(db)

    async def get_streak(self, user: User) -> EmotionStreakOut:
        """Racha de días consecutivos con al menos un registro emocional."""
        log_dates = set(await self.repo.get_distinct_log_dates(user.id))
        today = date.today()
        logged_today = today in log_dates

        # Racha actual: si hoy aún no registra, la racha sigue viva desde ayer.
        current = 0
        cursor = today if logged_today else today - timedelta(days=1)
        while cursor in log_dates:
            current += 1
            cursor -= timedelta(days=1)

        longest = 0
        run = 0
        previous = None
        for day in sorted(log_dates):
            run = run + 1 if previous is not None and (day - previous).days == 1 else 1
            longest = max(longest, run)
            previous = day

        return EmotionStreakOut(
            current_streak=current,
            longest_streak=max(longest, current),
            logged_today=logged_today,
        )

    async def create_log(self, user: User, data: EmotionLogCreate) -> EmotionLog:
        emotion_type = await self.repo.get_emotion_type_by_id(data.emotion_type_id)
        if not emotion_type:
            raise BadRequestError("Tipo de emoción no encontrado")
        if not emotion_type.is_system and emotion_type.user_id != user.id:
            raise ForbiddenError("No tienes acceso a ese tipo de emoción")

        log = EmotionLog(
            user_id=user.id,
            emotion_type_id=data.emotion_type_id,
            intensity=data.intensity,
            note=data.note,
            context_place=data.context_place,
            context_activity=data.context_activity,
            context_people=data.context_people,
            logged_at=data.logged_at,
        )
        return await self.repo.create_with_tags(log, data.tag_ids or [], user.id)

    async def list_logs(
        self,
        user: User,
        start_date: Optional[datetime] = None,
        end_date: Optional[datetime] = None,
        emotion_type_id: Optional[UUID] = None,
        min_intensity: Optional[int] = None,
        max_intensity: Optional[int] = None,
        q: Optional[str] = None,
        limit: int = 20,
        offset: int = 0,
    ) -> List[EmotionLog]:
        return await self.repo.list_with_filters(
            user.id, start_date, end_date, emotion_type_id,
            min_intensity, max_intensity, q, limit, offset,
        )

    async def get_log(self, user: User, log_id: UUID) -> EmotionLog:
        log = await self.repo.get_with_tags(log_id)
        if not log:
            raise NotFoundError("Registro emocional no encontrado")
        if log.user_id != user.id:
            raise ForbiddenError()
        return log

    async def update_log(self, user: User, log_id: UUID, data: EmotionLogUpdate) -> EmotionLog:
        log = await self.get_log(user, log_id)
        if data.intensity is not None:
            log.intensity = data.intensity
        if data.note is not None:
            log.note = data.note
        await self.repo.db.flush()
        if data.tag_ids is not None:
            return await self.repo.update_tags(log, data.tag_ids, user.id)
        return await self.repo.get_with_tags(log.id)

    async def delete_log(self, user: User, log_id: UUID) -> None:
        log = await self.get_log(user, log_id)
        await self.repo.delete(log)
