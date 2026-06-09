from app.workers.celery_app import celery_app


@celery_app.task(name="app.workers.tasks.summary_tasks.generate_weekly_summary")
def generate_weekly_summary():
    pass