#!/bin/bash

# ============================
# EXTEND ENVIRONMENT VARIABLES
. ./01_environment_vars.sh
# ============================

# Ensure the profile is loaded (once).
[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && [ . $HOME_VAGRANT/.profile]
workon kc

cd $KOBOCAT_PATH

python manage.py runserver 0.0.0.0:$KOBOCAT_SERVER_PORT
