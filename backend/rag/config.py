
from pathlib import Path

import os

PROJECT_ROOT = Path(__file__).resolve().parents[2]

UPLOAD_DIR = PROJECT_ROOT / "backend" / "uploads"
# Use environment variable for persistent chroma directory, default to /app/chroma_db on Render
CHROMA_DIR = Path(os.getenv("CHROMA_PERSIST_DIR", "/app/chroma_db"))

COLLECTION_NAME = "evalora_knowledge"

EMBEDDING_MODEL = "sentence-transformers/all-MiniLM-L6-v2"

CHUNK_SIZE = 1000
CHUNK_OVERLAP = 200

TOP_K = 6

UPLOAD_DIR.mkdir(parents=True, exist_ok=True)
CHROMA_DIR.mkdir(parents=True, exist_ok=True)
