#!/usr/bin/env bash

# =======================================
# EXTEND ENVIRONMENT VARIABLES
if [ -d /home/vagrant ]; then
    SCRIPT_DIR=/vagrant/scripts
else
    THIS_SCRIPT_PATH=$(readlink -f "$0")
    SCRIPT_DIR=$(dirname "$THIS_SCRIPT_PATH")
fi
. $SCRIPT_DIR/01_environment_vars.sh
# =======================================

# Ensure the profile is loaded (once).
[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && . $HOME_VAGRANT/.profile
workon kf

cd $KOBOFORM_PATH

python manage.py gruntserver 0.0.0.0:$KOBOFORM_SERVER_PORT
