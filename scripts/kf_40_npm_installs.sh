#!/usr/bin/env sh

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

install_info "KF NPM installs"

cd $KOBOFORM_PATH

npm install bower
[ $(whoami) = "root" ] &&   bower install --config.interactive=false --allow-root
[ ! $(whoami) = "root" ] && bower install --config.interactive=false
npm install
