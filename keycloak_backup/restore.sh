#!/bin/bash
set -e

# Start the PostgreSQL service
docker-entrypoint.sh postgres &

# Wait for PostgreSQL to start
until pg_isready -U keycloak; do
  sleep 1
done

# Check if the database exists, create if it doesn't
psql -U keycloak -tc "SELECT 1 FROM pg_database WHERE datname = 'keycloak'" | grep -q 1 || psql -U keycloak -c "CREATE DATABASE keycloak"

# Restore the backup if it exists
if [ -f /docker-entrypoint-initdb.d/keycloak_backup.sql ]; then
  psql -U keycloak -d keycloak < /docker-entrypoint-initdb.d/keycloak_backup.sql
fi

# Bring PostgreSQL to the foreground
wait




