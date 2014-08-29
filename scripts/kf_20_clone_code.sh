#!/bin/sh -u

# ============================
# EXTEND ENVIRONMENT VARIABLES
. ./01_environment_vars.sh
# ============================

install_info "KF clone code"

# If on a Vagrant system, check that the current user is 'vagrant'
[ $(whoami) = "vagrant" ] || [ -d /home/vagrant ] && { echo "$0 must be run as user 'vagrant'"; exit 1; }

[ -d "$KOBOFORM_PATH" ] || { git clone $KOBOFORM_REPO $KOBOFORM_PATH -b $KOBOFORM_BRANCH; }
