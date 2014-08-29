#!/bin/bash

# ============================
# EXTEND ENVIRONMENT VARIABLES
. ./01_environment_vars.sh
# ============================

# kf_3_install_pip_requirements
[ $(whoami) = "vagrant" ] || { echo "$0 must be run as user 'vagrant'"; exit 1; }

# Ensure the profile is loaded (once).
[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && [ . $HOME_VAGRANT/.profile ]
workon kf

cd $KOBOFORM_PATH
pip install -r requirements.txt
