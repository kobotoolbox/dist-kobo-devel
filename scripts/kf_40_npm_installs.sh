#!/bin/sh -u

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

install_info "KF NPM installs"

cd $KOBOFORM_PATH

npm install bower
bower install -s
npm install
