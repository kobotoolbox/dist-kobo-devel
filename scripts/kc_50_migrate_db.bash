#!/bin/bash

# scripts/kc_50_migrate_db.sh

# ============================
# EXTEND ENVIRONMENT VARIABLES
. ./01_environment_vars.sh
# ============================

install_info "Migrate KC Database"

cd $KOBOCAT_PATH

# Ensure the profile is loaded (once).
[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && [ . $HOME_VAGRANT/.profile ]
workon kc

python manage.py syncdb --noinput
python manage.py migrate --noinput

echo "from django.contrib.auth.models import User; User.objects.create_superuser('kobo', 'kobo@example.com', 'kobo');" | python manage.py shell
