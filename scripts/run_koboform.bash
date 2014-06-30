#!/bin/bash -u

# =======================================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# =======================================

. ~/.profile
workon kf
cd $KOBOFORM_PATH

python manage.py gruntserver 0.0.0.0:8000
