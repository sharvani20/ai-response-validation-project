# Dockerfile – Render deployment (memory‑optimized)

FROM python:3.11-slim AS base

# Install minimal system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc && \
    rm -rf /var/lib/apt/lists/*

# Create a non‑root user and set workdir
RUN useradd -m appuser
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire source tree (backend, frontend, etc.)
COPY . .

# Create directory for persistent ChromaDB storage
RUN mkdir -p /app/chroma_db

# Switch to non‑root user
USER appuser

# Expose the port Render provides via $PORT (default 10000)
ENV PORT=${PORT:-10000}
EXPOSE $PORT

# Start FastAPI with a single worker to limit memory usage
CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "$PORT", "--workers", "1"]
