import logging
from datetime import datetime, timedelta

from airflow import DAG  # type: ignore
from airflow.operators.bash import BashOperator  # type: ignore
from airflow.operators.python import PythonOperator  # type: ignore

# from etl_scripts.fetch_api import fetch_api_data
# from etl_scripts.scraper import scrape_yahoo_finance_news
#


def hello_world():
    print("Hello World")


default_args = {
    "owner": "minh",
    "depends_on_past": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    dag_id="minh_dag",
    start_date=datetime(2025, 12, 19),
    schedule="@daily",
    tags=["scrapping", "finance", "postgres"],
) as dag:
    hello_task = PythonOperator(task_id="hello_world", python_callable=hello_world)

    hello_task
