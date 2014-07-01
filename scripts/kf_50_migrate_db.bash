#!/bin/sh -u

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

install_info "Migrate KF Database"

cd $KOBOFORM_PATH
. /home/vagrant/.profile
workon kf

python manage.py syncdb --noinput
python manage.py migrate --noinput
