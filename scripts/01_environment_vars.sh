#!/usr/bin/env bash

# ENVIRONMENT PRESETS ALREADY IN /vagrant/koborc 	# <-- checked into the repository
# THIS FILE PULLS IN THE ENVIRONMENT AS DEFINED IN /vagrant/(env_kobocat|env_koboform) # respectively, for each project
# THESE VALUES MAY BE OVERRIDDEN BY /vagrant/env.sh (optional file) # <-- not checked into the repository

# scripts/01_environment_vars.sh

install_info() {
    echo "KoBoToolbox install: [$0] $1"
}

if [ -d /home/vagrant ]; then
    export HOME_VAGRANT=${HOME_VAGRANT:-"/home/vagrant"}
    export PROFILE_PATH=$HOME_VAGRANT/.profile
else
    export HOME_VAGRANT=$HOME
    [ `whoami` = "root" ] && export PROFILE_PATH=/root/.profile
    [ ! `whoami` = "root" ] && export PROFILE_PATH=$HOME_VAGRANT/.profile
fi

export PIP_DOWNLOAD_CACHE=${PIP_DOWNLOAD_CACHE:-"$HOME_VAGRANT/.pip_cache"}

# Directories.
if [ -d /home/vagrant ]; then
    SCRIPT_DIR=/home/vagrant/scripts
else
    THIS_SCRIPT_PATH=$(readlink -f "$0")
    SCRIPT_DIR=$(dirname "$THIS_SCRIPT_PATH")
fi
export V_R=${V_R:-"$(readlink -f $SCRIPT_DIR/..)"} # vagrant root
export V_E=${V_E:-"$HOME_VAGRANT/env"}
export V_S=${V_S:-"$HOME_VAGRANT/scripts"}
export V_L=${V_L:-"$HOME_VAGRANT/logs"}
export SRC_DIR=${SRC_DIR:-"$HOME_VAGRANT/src"}
# export KOBOCAT=${KOBOCAT:-"kobocat"}


# override the server IP if it is set
export SERVER_IP=${SERVER_IP:-"127.0.0.1"}
[ -f "$V_E/SERVER_IP.sh" ] && { . $V_E/SERVER_IP.sh; }

[ -f "$V_E/KOBO_OFFLINE.sh" ] && { . $V_E/KOBO_OFFLINE.sh; }

# deployment / server details

# the following variable should be overridden for non-localhost deployments
export KOBOFORM_URL=${KOBOFORM_URL:-"http://localhost:8000"}

export KOBOFORM_SERVER_PORT=${KOBOFORM_SERVER_PORT:-"8000"}

# the following variable should be overridden for non-localhost deployments
export KOBOCAT_URL=${KOBOCAT_URL:-"http://localhost:8001"}

export KOBOCAT_SERVER_PORT=${KOBOCAT_SERVER_PORT:-"8001"}
export KOBOCAT_INTERNAL_URL=${KOBOCAT_INTERNAL_URL:-"http://localhost:8001"}
export ENKETO_EXPRESS_SERVER_PORT=${ENKETO_EXPRESS_SERVER_PORT:-"8005"}

# export DIST_KOBO_DEVEL=${DIST_KOBO_DEVEL:-"dist-kobo-devel"}

export KOBOCAT_REPO=${KOBOCAT_REPO:-"https://github.com/kobotoolbox/kobocat.git"}
export KOBOCAT_BRANCH=${KOBOCAT_BRANCH:-"master"}
export KOBOCAT_PATH=${KOBOCAT_PATH:-"$SRC_DIR/kobocat"}

export KOBOCAT_TEMPLATES_REPO=${KOBOCAT_TEMPLATES_REPO:-"https://github.com/kobotoolbox/kobocat-template.git"}
export KOBOCAT_TEMPLATES_BRANCH=${KOBOCAT_TEMPLATES_BRANCH:-"master"}
export KOBOCAT_TEMPLATES_PATH=${KOBOCAT_TEMPLATES_PATH:-"$SRC_DIR/kobocat-template"}

export KOBOFORM_PREVIEW_SERVER=${KOBOFORM_PREVIEW_SERVER:-"http://$SERVER_IP:$KOBOFORM_SERVER_PORT"}
export KOBOFORM_REPO=${KOBOFORM_REPO:-"https://github.com/kobotoolbox/dkobo.git"}
export KOBOFORM_BRANCH=${KOBOFORM_BRANCH:-"master"}
export KOBOFORM_PATH=${KOBOFORM_PATH:-"$SRC_DIR/koboform"}

export PSQL_ADMIN=${PSQL_ADMIN:-"postgres"}
export KOBO_PSQL_DB_NAME=${KOBO_PSQL_DB_NAME:-"kobotoolbox"}
export KOBO_PSQL_DB_USER=${KOBO_PSQL_DB_USER:-"kobo"}
export KOBO_PSQL_DB_PASS=${KOBO_PSQL_DB_PASS:-"kobo"}
export DATABASE_SERVER_IP=${DATABASE_SERVER_IP:-"localhost"}
export DATABASE_URL=${DATABASE_URL:-"postgis://$KOBO_PSQL_DB_USER:$KOBO_PSQL_DB_PASS@$DATABASE_SERVER_IP:5432/$KOBO_PSQL_DB_NAME"}

export DEFAULT_KOBO_USER=${DEFAULT_KOBO_USER:-"kobo"}
export DEFAULT_KOBO_PASS=${DEFAULT_KOBO_PASS:-"kobo"}

# Enketo-Express-related configurations.
# For Enketo Express's installation script ('enketo-express/setup/bootstrap.sh').
export ENKETO_EXPRESS_REPO_DIR=${ENKETO_EXPRESS_REPO_DIR:-"$SRC_DIR/enketo-express"}
export ENKETO_EXPRESS_UPDATE_REPO=${ENKETO_EXPRESS_UPDATE_REPO:-"false"}

# For KoBoForm.

# the following variable should be overridden for non-localhost deployments
export ENKETO_SERVER=${ENKETO_SERVER:-"http://localhost:8005"}

export ENKETO_PREVIEW_URI=${ENKETO_PREVIEW_URI:-"/preview"}
# For KoBoCat.

# the following variable should be overridden for non-localhost deployments
export ENKETO_URL=${ENKETO_URL:-"http://localhost:8005"}

export ENKETO_API_URL_PARTIAL=${ENKETO_API_URL_PARTIAL:-"/api/v2"}
export ENKETO_PREVIEW_URL_PARTIAL=${ENKETO_PREVIEW_URL_PARTIAL:-"/preview"}
export ENKETO_OFFLINE_SURVEYS=${ENKETO_OFFLINE_SURVEYS:-"True"}
export ENKETO_PROTOCOL=${ENKETO_PROTOCOL:-"http"}

export ENKETO_API_TOKEN=${ENKETO_API_TOKEN:-"enketorules"}
# enk_token_file="~/.enketo-express-api-token.txt"
# [ ! -f "$enk_token_file" ] && { python -c "import json;f=open('$ENKETO_EXPRESS_REPO_DIR/config/config.json');print json.loads(f.read()).get('linked form and data server').get('api key')" > $enk_token_file; }
# export ENKETO_API_TOKEN=$(cat $enk_token_file)

# django settings specific details
export DJANGO_LIVE_RELOAD=${DJANGO_LIVE_RELOAD:-"False"}
export DJANGO_SITE_ID=${DJANGO_SITE_ID:-"1"}
export DJANGO_SECRET_KEY=${DJANGO_SECRET_KEY:-"P2Nerc3oG2564z5mHTGUhAoh2CzOMVenWBNMNWgWU796n"}


ENV_OVERRIDE_FILE="env.sh"

# export CSRF_COOKIE_DOMAIN=${CSRF_COOKIE_DOMAIN:-".local.kobotoolbox.org"}
# localhost is not a valid CSRF_COOKIE_DOMAIN in chrome

# overridden when servers should not be started
export AUTOLAUNCH=${AUTOLAUNCH:-"1"}


if [ -f "$V_E/$ENV_OVERRIDE_FILE" ]; then
	. $V_E/$ENV_OVERRIDE_FILE
fi

# virtualenvwrapper is acting weird. will this substitute work?
kobo_workon () {
	. $HOME/.virtualenvs/$1/bin/activate && . $HOME/.virtualenvs/$1/bin/postactivate
}
kobo_mkvirtualenv () {
	virtualenv $HOME/.virtualenvs/$1 --system-site-packages
	touch $HOME/.virtualenvs/$1/bin/postactivate
	kobo_workon $1
}

