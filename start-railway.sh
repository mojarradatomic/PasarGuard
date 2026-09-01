#!/usr/bin/env bash
set -e

export UVICORN_HOST="0.0.0.0"
export UVICORN_PORT="${PORT:-8000}"

export SQLALCHEMY_DATABASE_URL="${SQLALCHEMY_DATABASE_URL:-sqlite+aiosqlite:///db.sqlite3}"

export ROLE="${ROLE:-all-in-one}"

export UVICORN_PROXY_HEADERS="${UVICORN_PROXY_HEADERS:-true}"
export UVICORN_FORWARDED_ALLOW_IPS="${UVICORN_FORWARDED_ALLOW_IPS:-*}"

echo "Starting PasarGuard panel on port ${UVICORN_PORT}..."

exec /code/start.sh
