from typing import List, Literal, Optional

from pydantic import BaseModel


class CoachInsightOut(BaseModel):
    code: str
    priority: Literal["low", "medium", "high"]
    message: str


class CoachSummaryOut(BaseModel):
    total_logs: int
    avg_intensity: Optional[float]
    habits_completion_pct: Optional[float]
    dominant_emotion_name: Optional[str]
    pending_habits_count: int


class CoachInsightsOut(BaseModel):
    hero_label: str
    hero_description: str
    insights: List[CoachInsightOut]
    summary: CoachSummaryOut
