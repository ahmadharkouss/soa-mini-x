#!/bin/bash
set -e

# Start the PostgreSQL service
docker-entrypoint.sh postgres &

# Wait for PostgreSQL to start
until pg_isready -U keycloak; do
  sleep 1
done

# Restore the backup
if [ -f /docker-entrypoint-initdb.d/keycloak_backup.sql ]; then
  psql -U keycloak -d keycloak < /docker-entrypoint-initdb.d/keycloak_backup.sql
fi

# Bring PostgreSQL to the foreground
wait



