#!/usr/bin/env sh

# scripts/05_create_database.sh

set -e

# ============================
# EXTEND ENVIRONMENT VARIABLES
if [ -d /home/vagrant ]; then
    SCRIPT_DIR=/home/vagrant/scripts
else
    THIS_SCRIPT_PATH=$(readlink -f "$0")
    SCRIPT_DIR=$(dirname "$THIS_SCRIPT_PATH")
fi
. $SCRIPT_DIR/01_environment_vars.sh
# ============================

[ -n "$KOBO_SKIP_INSTALL" ] && exit 0

install_info "Creating postgres database"

if [ $(psql -l | grep $KOBO_PSQL_DB_NAME | wc -l) = "0" ]; then
	createdb $KOBO_PSQL_DB_NAME
	psql -d template1 -c "CREATE USER `echo $KOBO_PSQL_DB_USER` WITH PASSWORD '`echo $KOBO_PSQL_DB_PASS`';"
	psql -d template1 -c "GRANT ALL PRIVILEGES ON DATABASE `echo $KOBO_PSQL_DB_NAME` to `echo $KOBO_PSQL_DB_USER`;"
	psql -c "CREATE EXTENSION IF NOT EXISTS postgis;" -d $KOBO_PSQL_DB_NAME
	psql -c "CREATE EXTENSION IF NOT EXISTS postgis_topology;" -d $KOBO_PSQL_DB_NAME
fi
