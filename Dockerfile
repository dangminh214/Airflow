FROM apache/airflow:slim-3.1.6-python3.12

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml uv.lock ./

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

USER airflow

RUN uv sync --active

COPY dags /opt/airflow/dags
COPY config /opt/airflow/config
COPY main.py /opt/airflow/
COPY plugins /opt/airflow/plugins
COPY config/airflow.cfg /opt/airflow/config/airflow.cfg

EXPOSE 8080
