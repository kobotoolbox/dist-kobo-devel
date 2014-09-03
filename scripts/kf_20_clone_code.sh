#!/bin/sh -u

# ============================
# EXTEND ENVIRONMENT VARIABLES
if [ -d /home/vagrant ]; then
    SCRIPT_DIR=/vagrant/scripts
else
    THIS_SCRIPT_PATH=$(readlink -f "$0")
    SCRIPT_DIR=$(dirname "$THIS_SCRIPT_PATH")
fi
. $SCRIPT_DIR/01_environment_vars.sh
# ============================

install_info "KF clone code"

# If on a Vagrant system, check that the current user is 'vagrant'
[ -d /home/vagrant ] && [ ! $(whoami) = "vagrant" ] && { echo "$0 must be run as user 'vagrant'"; exit 1; }

[ -d "$KOBOFORM_PATH" ] || { git clone --depth 1 $KOBOFORM_REPO $KOBOFORM_PATH -b $KOBOFORM_BRANCH; }
