from app.workers.celery_app import celery_app


@celery_app.task(name="app.workers.tasks.notification_tasks.send_daily_reminders")
def send_daily_reminders():
    pass


@celery_app.task(name="app.workers.tasks.notification_tasks.send_push_notification")
def send_push_notification(user_id: str, message: str):
    pass