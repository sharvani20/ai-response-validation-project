# Dockerfile – Render deployment (memory‑optimized)
FROM python:3.11-slim AS base

# Install minimal system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends gcc && rm -rf /var/lib/apt/lists/*

# Create a non‑root user
RUN useradd -m appuser
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code (backend and frontend)
COPY backend ./backend
COPY frontend ./frontend
COPY .env.example .env    # will be overridden in Render UI

# Switch to non‑root user
USER appuser

# Expose the port Render provides via $PORT (default 10000)
ENV PORT=${PORT:-10000}
EXPOSE $PORT

# Start FastAPI with a single worker to limit memory usage
CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "$PORT", "--workers", "1"]
