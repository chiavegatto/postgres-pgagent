#!/bin/bash
set -e

PG_AGENT_USER=$POSTGRES_USER
PG_AGENT_DB=$POSTGRES_DB

if [ "x$POSTGRES_USER" = "x" ]; then
    PG_AGENT_USER=postgres
fi

if [ "x$POSTGRES_DB" = "x" ]; then
    PG_AGENT_DB=$PG_AGENT_USER
fi

psql -v ON_ERROR_STOP=1 --username "$PG_AGENT_USER" --dbname "postgres" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS pgagent;
EOSQL

echo "starting pgagent"
echo "wait for it..."
sleep 20 && \
pgagent hostaddr=127.0.0.1 dbname=postgres user=$PG_AGENT_USER port=5432 && \
echo "pgagent started for user: $PG_AGENT_USER on database: $PG_AGENT_DB" &