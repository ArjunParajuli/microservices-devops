FROM python:3.12-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

ENV RECOMMENDATION_PORT=8013
ENV OTEL_SERVICE_NAME=recommendation-service
ENV PRODUCT_CATALOG_ADDR=productcatalog:8088

ENTRYPOINT ["python", "recommendation_server.py"]
