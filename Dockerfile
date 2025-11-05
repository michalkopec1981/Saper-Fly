# Dockerfile dla SAPER QR na Fly.io
FROM python:3.11-slim

# Ustaw zmienne środowiskowe
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

# Ustaw katalog roboczy
WORKDIR /app

# Zainstaluj zależności systemowe
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Skopiuj requirements
COPY requirements.txt .

# Zainstaluj zależności Pythona
RUN pip install --no-cache-dir -r requirements.txt gunicorn

# Skopiuj całą aplikację
COPY . .

# Utwórz folder na logi
RUN mkdir -p static/uploads/logos static/uploads/funny

# Expose port (Fly.io używa 8080 wewnętrznie)
EXPOSE 8080

# Uruchom aplikację z gunicorn + gevent
CMD ["gunicorn", "--worker-class", "geventwebsocket.gunicorn.workers.GeventWebSocketWorker", "--workers", "1", "--bind", "0.0.0.0:8080", "--timeout", "120", "--log-level", "info", "app:app"]
