#!/usr/bin/env bash

# =======================================
# EXTEND ENVIRONMENT VARIABLES
if [ -d /home/vagrant ]; then
    SCRIPT_DIR=/home/vagrant/scripts
else
    THIS_SCRIPT_PATH=$(readlink -f "$0")
    SCRIPT_DIR=$(dirname "$THIS_SCRIPT_PATH")
fi
. $SCRIPT_DIR/01_environment_vars.sh
# =======================================

# Ensure the profile is loaded (once).
[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && . $HOME_VAGRANT/.profile
kobo_workon kf

cd $KOBOFORM_PATH

python manage.py runserver 0.0.0.0:$KOBOFORM_SERVER_PORT
