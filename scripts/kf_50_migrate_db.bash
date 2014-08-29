#!/bin/bash

# ============================
# EXTEND ENVIRONMENT VARIABLES
. ./01_environment_vars.sh
# ============================

install_info "Migrate KF Database"

cd $KOBOFORM_PATH

# Ensure the profile is loaded (once).
[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && . $HOME_VAGRANT/.profile
workon kf

python manage.py syncdb --noinput
python manage.py migrate --noinput
