#!/bin/bash

# =======================================
# EXTEND ENVIRONMENT VARIABLES
. ./01_environment_vars.sh
# =======================================

# Ensure the profile is loaded (once).
[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && [ . $HOME_VAGRANT/.profile ]
workon kf

cd $KOBOFORM_PATH

python manage.py gruntserver 0.0.0.0:$KOBOFORM_SERVER_PORT
