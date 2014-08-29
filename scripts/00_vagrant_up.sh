#!/bin/sh -u

# scripts/00_vagrant_up.sh

set -e

# ============================
# EXTEND ENVIRONMENT VARIABLES
. ./01_environment_vars.sh
# ============================

sudo apt-get update

# TODO: Check release number and instead install `software-properties-common` for > 12.04
#   (see http://stackoverflow.com/a/16032073)
sudo apt-get install -y python-software-properties git-core

[ -f $HOME_VAGRANT/.mark_keys_added ] || {
    sudo -u root sh $V_S/02_installation_keys.sh
}

sudo -u root        sh   $V_S/03_apt_installs.sh
[ $? -ne 0 ] && { install_info "Dependencies were not properly installed"; exit 1; }

sudo -u root        sh   $V_S/04_postgis_extensions.sh
[ $? -ne 0 ] && { install_info "Dependencies were not properly installed"; exit 1; }

sudo -u postgres    sh   $V_S/05_create_database.sh
sudo -u vagrant     bash $V_S/kc_10_virtualenvs.bash
[ $? -ne 0 ] && { install_info "virtualenv was not created"; exit 1; }

sudo -u vagrant     sh   $V_S/kc_20_clone_code.sh
sudo -u vagrant     bash $V_S/kc_30_install_pip_requirements.bash
sudo -u root        sh   $V_S/kc_40_npm_installs.sh
sudo -u vagrant     bash $V_S/kc_50_migrate_db.bash


sudo -u vagrant     bash $V_S/kf_10_virtualenvs.bash
[ $? -ne 0 ] && { install_info "virtualenv was not created"; exit 1; }

sudo -u vagrant     sh   $V_S/kf_20_clone_code.sh
sudo -u vagrant     bash $V_S/kf_30_install_pip_requirements.bash
sudo -u vagrant     sh   $V_S/kf_40_npm_installs.sh
sudo -u vagrant     bash $V_S/kf_50_migrate_db.bash

sudo -u vagrant     sh   $V_S/09_add_cronjobs.sh

echo "Done with installation"
