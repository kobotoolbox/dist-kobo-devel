#!/bin/sh -u

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

# kf_3_install_pip_requirements
[ $(whoami) = "vagrant" ] || { echo "$0 must be run as user 'vagrant'"; exit 1; }

. /usr/local/bin/virtualenvwrapper.sh
workon kf

cd $KOBOFORM_PATH
pip install -r requirements.txt
