#!/usr/bin/env bash

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

install_info "Migrate KF Database"

cd $KOBOFORM_PATH

# Ensure the profile is loaded (once).
[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && . $HOME_VAGRANT/.profile
kobo_workon kf

python manage.py syncdb --noinput
python manage.py migrate --noinput

echo "from django.contrib.auth.models import User; print 'UserExists' if User.objects.filter(username='$DEFAULT_KOBO_USER').count() > 0 else User.objects.create_superuser('$DEFAULT_KOBO_USER', 'kobo@example.com', '$DEFAULT_KOBO_PASS');" | python manage.py shell 2>&1

exit 0
