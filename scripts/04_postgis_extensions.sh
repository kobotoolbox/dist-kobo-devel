#!/usr/bin/env bash

# scripts/04_postgis_extensions.sh

# ============================
# EXTEND ENVIRONMENT VARIABLES
if [ -d /home/vagrant ]; then
    SCRIPT_DIR=/vagrant/scripts
else
    THIS_SCRIPT_PATH=$(readlink -f "$0")
    SCRIPT_DIR=$(dirname "$THIS_SCRIPT_PATH")
fi
. $SCRIPT_DIR/01_environment_vars.sh
# ============================

install_info "Install PostGIS"

# Postgis instructions from here:
# http://gis.stackexchange.com/questions/88207/installing-postgis-on-ubuntu-12-04-unmet-dependencies-libgdal1

sudo apt-get -y install qgis python-qgis postgresql-9.3 postgresql-9.3-postgis-2.1
