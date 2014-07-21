#!/bin/sh -u

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

install_info "Migrate KF Database"

cd $KOBOFORM_PATH
. $HOME_VAGRANT/.profile
workon kf

python manage.py syncdb --noinput
python manage.py migrate --noinput
