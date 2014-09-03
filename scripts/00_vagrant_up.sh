#!/usr/bin/env bash

# scripts/00_vagrant_up.sh

set -e

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

[ -f $HOME_VAGRANT/.mark_keys_added ] || {
    sudo -u root sh $V_S/02_installation_keys.sh
}

sudo -u root        sh   $V_S/03_apt_installs.sh
[ $? -ne 0 ] && { install_info "Dependencies were not properly installed"; exit 1; }

sudo -u root        sh   $V_S/04_postgis_extensions.sh
[ $? -ne 0 ] && { install_info "Dependencies were not properly installed"; exit 1; }

# Idempotently ensure that PostgreSQL is running.
sudo service postgresql start
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
sudo -u vagrant     HOME=$VAGRANT_HOME sh   $V_S/kf_40_npm_installs.sh
sudo -u vagrant     bash $V_S/kf_50_migrate_db.bash
#sudo -u vagrant     bash $V_S/enketo_install.bash

sudo -u vagrant     sh   $V_S/09_add_cronjobs.sh

echo "Done with installation"
