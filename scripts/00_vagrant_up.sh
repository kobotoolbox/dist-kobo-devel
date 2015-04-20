#!/usr/bin/env bash

# scripts/00_vagrant_up.sh

set -e

# ============================
# EXTEND ENVIRONMENT VARIABLES
if [ -d /home/vagrant ]; then
    # For Vagrant installations.
    SCRIPT_DIR=/home/vagrant/scripts
else
    # Non-Vagrant.
    THIS_SCRIPT_PATH=$(readlink -f "$0")
    SCRIPT_DIR=$(dirname "$THIS_SCRIPT_PATH")
fi
. $SCRIPT_DIR/01_environment_vars.sh
# ============================

# Install 'apt' repository keys if not already done.
[ -f $HOME_VAGRANT/.mark_keys_added ] || {
    su - root -c "sh $V_S/02_installation_keys.sh"
}

su - root -c        "sh   $V_S/03_apt_installs.sh"

su - root -c        "sh   $V_S/04_postgis_extensions.sh"

# Idempotently ensure that PostgreSQL is running.
sudo service postgresql start
su - postgres -c    "sh   $V_S/05_create_database.sh"

# KoBoCat:
su - vagrant -c     "bash $V_S/kc_10_virtualenvs.bash"
su - vagrant -c     "sh   $V_S/kc_20_clone_code.sh"
su - vagrant -c     "bash $V_S/kc_30_install_pip_requirements.bash"
su - root -c        "sh   $V_S/kc_40_npm_installs.sh"
su - vagrant -c     "bash $V_S/kc_50_migrate_db.bash"
su - root -c        "bash $V_S/kc_60_environment_setup.bash"

# KoBoForm:
su - vagrant -c     "bash $V_S/kf_10_virtualenvs.bash"
su - vagrant -c     "sh   $V_S/kf_20_clone_code.sh"
su - vagrant -c     "bash $V_S/kf_30_install_pip_requirements.bash"
su - vagrant -c     "HOME=$HOME_VAGRANT sh   $V_S/kf_40_npm_installs.sh"
su - vagrant -c     "bash $V_S/kf_50_migrate_db.bash"

# Enketo Express:
su - root -c        "bash $V_S/enketo_install.old.bash"

su - vagrant -c     "sh   $V_S/09_add_cronjobs.sh"

echo "Done with installation"
