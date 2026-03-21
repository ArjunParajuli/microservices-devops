# --------------------------- Stage 1: Build dependencies ----------------------------------
FROM python:3.12-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# ------------------------------ Stage 2: Runtime (lightweight) ------------------
FROM python:3.12-slim

WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /usr/local/lib/python3.12 /usr/local/lib/python3.12
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy only required app files
COPY . .

ENV RECOMMENDATION_PORT=8013
ENV OTEL_SERVICE_NAME=recommendation-service
ENV PRODUCT_CATALOG_ADDR=productcatalog:8088

ENTRYPOINT ["python", "recommendation_server.py"]
