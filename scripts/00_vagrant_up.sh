#!/bin/sh -u

# scripts/00_vagrant_up.sh

set -e

# export CURDIR=`pwd`
# export VAGRANT_SCRIPTS="/vagrant/scripts"
# export VHOME="/home/vagrant"
# export VS="/vagrant/scripts"

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

sudo apt-get install -y python-software-properties git-core

[ -f $HOME/.mark_keys_added ] || {
    sudo -u root sh /vagrant/scripts/02_installation_keys.sh
}

sudo -u root        sh   /vagrant/scripts/03_apt_installs.sh
[ $? -ne 0 ] && { install_info "Dependencies were not properly installed"; exit 1; }

sudo -u root        sh   /vagrant/scripts/04_postgis_extensions.sh
[ $? -ne 0 ] && { install_info "Dependencies were not properly installed"; exit 1; }

sudo -u postgres    sh   /vagrant/scripts/05_create_database.sh
sudo -u vagrant     bash /vagrant/scripts/kc_10_virtualenvs.bash
[ $? -ne 0 ] && { install_info "virtualenv was not created"; exit 1; }

sudo -u vagrant     sh   /vagrant/scripts/kc_20_clone_code.sh
sudo -u vagrant     bash /vagrant/scripts/kc_30_install_pip_requirements.bash
sudo -u root        sh   /vagrant/scripts/kc_40_npm_installs.sh
sudo -u vagrant     bash /vagrant/scripts/kc_50_migrate_db.bash


sudo -u vagrant     bash /vagrant/scripts/kf_10_virtualenvs.bash
[ $? -ne 0 ] && { install_info "virtualenv was not created"; exit 1; }

sudo -u vagrant     sh   /vagrant/scripts/kf_20_clone_code.sh
sudo -u vagrant     bash /vagrant/scripts/kf_30_install_pip_requirements.bash
sudo -u root        sh   /vagrant/scripts/kf_40_npm_installs.sh
sudo -u vagrant     bash /vagrant/scripts/kf_50_migrate_db.bash

sudo -u vagrant     sh   /vagrant/scripts/09_add_cronjobs.sh

echo "Done with installation"
