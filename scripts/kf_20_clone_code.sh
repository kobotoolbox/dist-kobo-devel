#!/bin/sh -u

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

install_info "KF clone code"

[ $(whoami) = "vagrant" ] || { echo "$0 must be run as user 'vagrant'"; exit 1; }

[ -d "$KOBOFORM_PATH" ] || { git clone $KOBOFORM_REPO $KOBOFORM_PATH -b $KOBOFORM_BRANCH; }
