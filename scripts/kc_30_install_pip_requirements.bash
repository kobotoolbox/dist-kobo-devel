#!/usr/bin/env bash

# scripts/kc_30_install_pip_requirements.sh

# ============================
# EXTEND ENVIRONMENT VARIABLES
if [ -d /home/vagrant ]; then
    SCRIPT_DIR=/vagrant/scripts
else
    THIS_SCRIPT_PATH=$(readlink -f "$0")
    SCRIPT_DIR=$(dirname "$THIS_SCRIPT_PATH")
fi
. $SCRIPT_DIR/01_environment_vars.sh
# ============================

install_info "Installing KoBoCat pip requirements."

cd $KOBOCAT_PATH

# Ensure the profile is loaded (once).
[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && . $PROFILE_PATH
workon kc

if [ "$VIRTUAL_ENV" = "" ]; then
	echo "Virtualenv was not activated properly"
	exit 1;
fi

# savReaderWriter
[ $( pip freeze | grep savReaderWriter | wc -l ) = "0" ] && {
	# this is a large dependency
	# installing seperately to get it over with
	pip install https://bitbucket.org/fomcl/savreaderwriter/downloads/savReaderWriter-3.3.0.zip#egg=savreaderwriter;
}

# for unified database configurations
pip install dj-database-url

pip install -r $KOBOCAT_PATH/requirements/common.pip

sudo -u root pip install pybamboo
