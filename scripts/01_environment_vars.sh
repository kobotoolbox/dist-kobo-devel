#!/usr/bin/env bash

# ENVIRONMENT PRESETS ALREADY IN /vagrant/koborc 	# <-- checked into the repository
# THIS FILE PULLS IN THE ENVIRONMENT AS DEFINED IN /vagrant/(env_kobocat|env_koboform) # respectively, for each project
# THESE VALUES MAY BE OVERRIDDEN BY /vagrant/env.sh (optional file) # <-- not checked into the repository

# scripts/01_environment_vars.sh

install_info() {
    echo "KoBoToolbox install: [$0] $1"
}

if [ -d /home/vagrant ]; then
    export HOME_VAGRANT="/home/vagrant"
    export PROFILE_PATH=$HOME_VAGRANT/.profile
else
    export HOME_VAGRANT=$HOME
    [ `whoami` = "root" ] && export PROFILE_PATH=/root/.profile
    [ ! `whoami` = "root" ] && export PROFILE_PATH=$HOME_VAGRANT/.profile
fi

export PIP_DOWNLOAD_CACHE="$HOME_VAGRANT/.pip_cache"

# Directories.
if [ -d /home/vagrant ]; then
    SCRIPT_DIR=/vagrant/scripts
else
    THIS_SCRIPT_PATH=$(readlink -f "$0")
    SCRIPT_DIR=$(dirname "$THIS_SCRIPT_PATH")
fi
export V_R="$(readlink -f $SCRIPT_DIR/..)" # vagrant root
export V_E="$V_R/env"
export V_S="$V_R/scripts"
export V_L="$V_R/logs"
# export KOBOCAT="kobocat"


# deployment / server details
export SERVER_IP="127.0.0.1"
export KOBOFORM_SERVER="$SERVER_IP"
export KOBOFORM_SERVER_PORT="8000"
export KOBOCAT_SERVER="$SERVER_IP"
export KOBOCAT_SERVER_PORT="8001"
export KOBOFORM_URL="http://$KOBOFORM_SERVER:$KOBOFORM_SERVER_PORT"
export KOBOCAT_URL="http://$KOBOCAT_SERVER:$KOBOCAT_SERVER_PORT"
export ENKETO_EXPRESS_SERVER_PORT="8005"

# export DIST_KOBO_DEVEL="dist-kobo-devel"

export KOBOCAT_REPO="https://github.com/kobotoolbox/kobocat.git"
export KOBOCAT_BRANCH="master"
export KOBOCAT_PATH="$HOME_VAGRANT/kobocat"

export KOBOCAT_TEMPLATES_REPO="https://github.com/kobotoolbox/kobocat-template.git"
export KOBOCAT_TEMPLATES_BRANCH="master"
export KOBOCAT_TEMPLATES_PATH="$HOME_VAGRANT/kobocat-template"

export KOBOFORM_PREVIEW_SERVER="http://$SERVER_IP:$KOBOFORM_SERVER_PORT"
export KOBOFORM_REPO="https://github.com/kobotoolbox/dkobo.git"
export KOBOFORM_BRANCH="master"
export KOBOFORM_PATH="$HOME_VAGRANT/koboform"

export PSQL_ADMIN="postgres"
export KOBO_PSQL_DB_NAME="kobotoolbox"
export KOBO_PSQL_DB_USER="kobo"
export KOBO_PSQL_DB_PASS="kobo"
export DATABASE_URL="postgis://$KOBO_PSQL_DB_USER:$KOBO_PSQL_DB_PASS@$SERVER_IP:5432/$KOBO_PSQL_DB_NAME"

# Enketo-Express-related configurations.
# For Enketo Express's installation script ('enketo-express/setup/bootstrap.sh').
export ENKETO_EXPRESS_REPO_DIR="$HOME_VAGRANT/enketo-express"
export ENKETO_EXPRESS_UPDATE_REPO="false"
export ENKETO_EXPRESS_USE_NODE_ENV="true"
# For KoBoForm.
export ENKETO_SERVER="http://$SERVER_IP:$ENKETO_EXPRESS_SERVER_PORT"
export ENKETO_PREVIEW_URI="/preview"
# For KoBoCat.
export ENKETO_URL="http://$SERVER_IP:$ENKETO_EXPRESS_SERVER_PORT"
export ENKETO_API_URL_PARTIAL="/api/v1"
export ENKETO_PREVIEW_URL_PARTIAL="/preview"
export ENKETO_PROTOCOL="http"
[ -f $ENKETO_EXPRESS_REPO_DIR/config/config.json ] && export ENKETO_API_TOKEN=$(python -c "import json;f=open('$ENKETO_EXPRESS_REPO_DIR/config/config.json');print json.loads(f.read()).get('linked form and data server').get('api key')")

# django settings specific details
export DJANGO_LIVE_RELOAD="False"
export DJANGO_SITE_ID="1"
export DJANGO_SECRET_KEY="P2Nerc3oG2564z5mHTGUhAoh2CzOMVenWBNMNWgWU796n"


ENV_OVERRIDE_FILE="env.sh"

# export CSRF_COOKIE_DOMAIN=".local.kobotoolbox.org"
# localhost is not a valid CSRF_COOKIE_DOMAIN in chrome

# overridden when servers should not be started
export AUTOLAUNCH="1"


run_kobocat () {
	bash -c ". $PROFILE_PATH && workon kc && cd $KOBOCAT_PATH && python manage.py runserver 0.0.0.0:$KOBOCAT_SERVER_PORT"
}

run_koboform () {
	bash -c ". $PROFILE_PATH && workon kf && cd $KOBOFORM_PATH && python manage.py gruntserver 0.0.0.0:$KOBOFORM_SERVER_PORT"
}


if [ -f "$HOME_VAGRANT/$ENV_OVERRIDE_FILE" ]; then
	. $V_R/$ENV_OVERRIDE_FILE
fi
