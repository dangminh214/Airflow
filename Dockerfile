FROM apache/airflow:slim-3.1.6-python3.11

WORKDIR /opt/airflow

# Switch to root to install system-level dependencies
USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install uv using the official installer script
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Switch back to airflow user for security and Python package installation
USER airflow

# Copy local requirements
COPY requirements.txt .

# Copy main folders into dir
COPY dags /opt/airflow/dags

# Airflow 3 encourages using 'uv' for significantly faster installations
RUN uv add -r requirements.in -c requirements.txt
