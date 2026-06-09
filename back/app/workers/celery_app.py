from celery import Celery
from app.config import settings

celery_app = Celery(
    "mindtrack",
    broker=settings.celery_broker_url,
    backend=settings.celery_result_backend,
    include=[
        "app.workers.tasks.summary_tasks",
        "app.workers.tasks.notification_tasks",
    ],
)

celery_app.conf.update(
    task_serializer="json",
    accept_content=["json"],
    result_serializer="json",
    timezone="America/Panama",
    enable_utc=True,
)