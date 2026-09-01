#!/usr/bin/env bash
set -e

export UVICORN_HOST="0.0.0.0"
export UVICORN_PORT="${PORT:-8000}"

export SQLALCHEMY_DATABASE_URL="${SQLALCHEMY_DATABASE_URL:-sqlite+aiosqlite:///db.sqlite3}"

export ROLE="${ROLE:-all-in-one}"

export UVICORN_PROXY_HEADERS="${UVICORN_PROXY_HEADERS:-true}"
export UVICORN_FORWARDED_ALLOW_IPS="${UVICORN_FORWARDED_ALLOW_IPS:-*}"

# Decode SSL cert/key from base64 env vars (set in Railway Variables)
if [ -n "$SSL_CERT_B64" ] && [ -n "$SSL_KEY_B64" ]; then
    mkdir -p /code/ssl
    echo "$SSL_CERT_B64" | base64 -d > /code/ssl/cert.pem
    echo "$SSL_KEY_B64" | base64 -d > /code/ssl/key.pem
    export UVICORN_SSL_CERTFILE="/code/ssl/cert.pem"
    export UVICORN_SSL_KEYFILE="/code/ssl/key.pem"
    echo "SSL cert/key loaded from environment. External access enabled."
else
    echo "WARNING: SSL_CERT_B64 / SSL_KEY_B64 not set. Panel will bind to localhost only."
fi

echo "Starting PasarGuard panel on port ${UVICORN_PORT}..."

exec /code/start.sh
