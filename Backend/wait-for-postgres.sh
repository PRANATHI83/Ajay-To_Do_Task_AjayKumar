#!/bin/sh
# wait-for-postgres.sh

set -e

host="$DB_HOST"
shift

until PGPASSWORD=$DB_PASSWORD psql -h "$host" -U "$DB_USER" -d "$DB_NAME" -c '\q'; do
  >&2 echo "⏳ Postgres is unavailable - sleeping"
  sleep 2
done

>&2 echo "✅ Postgres is up - starting server"
exec "$@"

