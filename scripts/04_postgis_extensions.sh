#!/bin/sh -u

# scripts/04_postgis_extensions.sh

# ============================
# EXTEND ENVIRONMENT VARIABLES
. ./01_environment_vars.sh
# ============================

# Postgis instructions from here:
# http://gis.stackexchange.com/questions/88207/installing-postgis-on-ubuntu-12-04-unmet-dependencies-libgdal1

sudo apt-get update

sudo apt-get -y install qgis python-qgis
sudo apt-get -y install postgresql-9.3
sudo apt-get -y install postgresql-9.3-postgis-2.1
