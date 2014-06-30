#!/bin/bash -u

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

whoami > /vagrant/logs/whoami

. ~/.profile
workon kc
cd $KOBOCAT_PATH

python manage.py runserver 0.0.0.0:8001
