#!/bin/sh -u

# ENVIRONMENT PRESETS ALREADY IN /vagrant/koborc 	# <-- checked into the repository
# THIS FILE PULLS IN THE ENVIRONMENT AS DEFINED IN /vagrant/(env_kobocat|env_koboform) # respectively, for each project
# THESE VALUES MAY BE OVERRIDDEN BY /vagrant/env.sh (optional file) # <-- not checked into the repository

# scripts/01_environment_vars.sh

install_info() {
    echo "KoBoToolbox install: [$0] $1"
}

export HOME="/home/vagrant"
export PIP_DOWNLOAD_CACHE="$HOME/.pip_cache"

export KOBO_PSQL_DB_USER="kobo"
export KOBO_PSQL_DB_PASS="kobo"
# export KOBO_PSQL_DB_NAME="kobotoolbox"

export VH="/vagrant"
export VS="/vagrant/scripts"
export KOBOCAT="kobocat"

export DIST_KOBO_DEVEL="dist-kobo-devel"

export KOBOCAT_REPO="https://github.com/kobotoolbox/kobocat.git"
export KOBOCAT_BRANCH="master"
export KOBOCAT_PATH="/vagrant/kobocat"

export KOBOCAT_TEMPLATES_REPO="https://github.com/kobotoolbox/kobocat-template.git"
export KOBOCAT_TEMPLATES_BRANCH="master"
export KOBOCAT_TEMPLATES_PATH="/vagrant/kobocat-template"

export KOBOFORM_REPO="https://github.com/kobotoolbox/dkobo.git"
export KOBOFORM_BRANCH="master"
export KOBOFORM_PATH="/vagrant/koboform"

export DATABASE_URL="postgis://kobo:kobo@localhost:5432/kobotoolbox"

export KOBOFORM_SERVER="localhost"
export KOBOFORM_SERVER_PORT="8000"
export KOBOCAT_SERVER="localhost"
export KOBOCAT_SERVER_PORT="8001"


export DJANGO_LIVE_RELOAD="False"
export DJANGO_SITE_ID="1"
export DJANGO_SECRET_KEY="P2Nerc3oG2564z5mHTGUhAoh2CzOMVenWBNMNWgWU796n"

# export CSRF_COOKIE_DOMAIN=".local.kobotoolbox.org"
# localhost is not a valid CSRF_COOKIE_DOMAIN in chrome

export AUTOLAUNCH="1"


run_kobocat () {
	bash -c ". ~/.profile && workon kc && cd $KOBOCAT_PATH && python manage.py runserver 0.0.0.0:$KOBOCAT_SERVER_PORT"
}

run_koboform () {
	bash -c ". ~/.profile && workon kf && cd $KOBOFORM_PATH && python manage.py gruntserver 0.0.0.0:$KOBOFORM_SERVER_PORT"
}


if [ -f "/vagrant/env.sh" ]; then
	. /vagrant/env.sh
fi
