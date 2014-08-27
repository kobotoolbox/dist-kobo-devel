#!/bin/sh -u

# scripts/05_create_database.sh

set -e

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

install_info "Creating postgres database"

if [ $(sudo -u postgres psql -l | grep kobotoolbox | wc -l) = "0" ]; then
	sudo -u postgres createdb kobotoolbox
	sudo -u postgres psql -d template1 -c "CREATE USER kobo WITH PASSWORD 'kobo';"
	sudo -u postgres psql -d template1 -c "GRANT ALL PRIVILEGES ON DATABASE kobotoolbox to kobo;"
	sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS postgis;" -d kobotoolbox
	sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS postgis_topology;" -d kobotoolbox
fi
