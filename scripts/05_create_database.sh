#!/bin/sh -u

# scripts/05_create_database.sh

set -e

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

install_info "Creating postgres database"

if [ $(psql -l | grep kobotoolbox | wc -l) = "0" ]; then
	createdb kobotoolbox
	psql -d template1 -c "CREATE USER kobo WITH PASSWORD 'kobo';"
	psql -d template1 -c "GRANT ALL PRIVILEGES ON DATABASE kobotoolbox to kobo;"
	psql -c "CREATE EXTENSION IF NOT EXISTS postgis;" -d kobotoolbox
	psql -c "CREATE EXTENSION IF NOT EXISTS postgis_topology;" -d kobotoolbox
fi