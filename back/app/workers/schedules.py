from celery.schedules import crontab
from app.workers.celery_app import celery_app

celery_app.conf.beat_schedule = {
    "generate-weekly-summary": {
        "task": "app.workers.tasks.summary_tasks.generate_weekly_summary",
        "schedule": crontab(hour=8, minute=0, day_of_week="monday"),
    },
    "send-daily-reminders": {
        "task": "app.workers.tasks.notification_tasks.send_daily_reminders",
        "schedule": crontab(hour=20, minute=0),
    },
}