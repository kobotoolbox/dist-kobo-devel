#!/bin/sh -u

# scripts/kc_40_npm_installs.sh

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

cd $KOBOCAT_PATH

install_info "Install some extra node dependencies"
sudo npm install -g --save-dev
sudo npm install -g bower karma grunt-cli
