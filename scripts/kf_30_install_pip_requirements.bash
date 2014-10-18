#!/usr/bin/env bash

# ============================
# EXTEND ENVIRONMENT VARIABLES
if [ -d /home/vagrant ]; then
    SCRIPT_DIR=/home/vagrant/scripts
else
    THIS_SCRIPT_PATH=$(readlink -f "$0")
    SCRIPT_DIR=$(dirname "$THIS_SCRIPT_PATH")
fi
. $SCRIPT_DIR/01_environment_vars.sh
# ============================
[ -n "$KOBO_SKIP_PIP_INSTALLS" ] && exit 0

# kf_3_install_pip_requirements
# If on a Vagrant system, check that the current user is 'vagrant'
[ -d /home/vagrant ] && [ ! $(whoami) = "vagrant" ] && { echo "$0 must be run as user 'vagrant'"; exit 1; }

# Ensure the profile is loaded (once).
[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && . $PROFILE_PATH
kobo_workon kf

cd $KOBOFORM_PATH
pip install -r requirements.txt
