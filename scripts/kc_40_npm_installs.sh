#!/usr/bin/env sh

# scripts/kc_40_npm_installs.sh

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
[ -n "$KOBO_SKIP_NPM_INSTALLS" ] && exit 0

cd $KOBOCAT_PATH

install_info "Install some extra node dependencies for KoBoCat."

sudo npm install -g --save-dev
sudo npm install -g bower karma grunt-cli

# $HOME is overridden for root
if [ $(whoami) = "vagrant" ]; then 
    sudo chown -R vagrant:vagrant $HOME_VAGRANT
fi

