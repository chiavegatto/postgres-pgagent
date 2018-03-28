#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "postgres" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS pgagent;
EOSQL

pgagent dbname=$POSTGRES_DB user=$POSTGRES_USER port=5432