#!/bin/sh -u

# scripts/01_environment_vars.sh

install_info() {
    echo "KoBoToolbox install: [$0] $1"
}

export HOME="/home/vagrant"

export KOBO_PSQL_DB_USER="kobo"
export KOBO_PSQL_DB_PASS="kobo"
export KOBO_PSQL_DB_NAME="kobocat"

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

#export KOBOFORM_SERVER="localhost"
#export KOBOFORM_SERVER_PORT="8000"
