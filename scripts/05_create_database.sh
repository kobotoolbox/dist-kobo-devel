#!/bin/sh -u

# scripts/05_create_database.sh

set -e

# ============================
# EXTEND ENVIRONMENT VARIABLES
. ./01_environment_vars.sh
# ============================

install_info "Creating postgres database"

# Idempotently ensure that PostgreSQL is running.
sudo service postgresql start

if [ $(sudo -u $PSQL_ADMIN psql -l | grep $KOBO_PSQL_DB_NAME | wc -l) = "0" ]; then
	sudo -u $PSQL_ADMIN createdb $KOBO_PSQL_DB_NAME
	sudo -u $PSQL_ADMIN psql -d template1 -c "CREATE USER `echo $KOBO_PSQL_DB_USER` WITH PASSWORD '`echo $KOBO_PSQL_DB_PASS`';"
	sudo -u $PSQL_ADMIN psql -d template1 -c "GRANT ALL PRIVILEGES ON DATABASE `echo $KOBO_PSQL_DB_NAME` to `echo $KOBO_PSQL_DB_USER`;"
	sudo -u $PSQL_ADMIN psql -c "CREATE EXTENSION IF NOT EXISTS postgis;" -d $KOBO_PSQL_DB_NAME
	sudo -u $PSQL_ADMIN psql -c "CREATE EXTENSION IF NOT EXISTS postgis_topology;" -d $KOBO_PSQL_DB_NAME
fi
