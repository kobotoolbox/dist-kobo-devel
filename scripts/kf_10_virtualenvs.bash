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
[ -n "$KOBO_SKIP_INSTALL" ] && exit 0

KENV="kf"
KENV_SHELL_EXTENDS="$V_E/env_koboform"
VENV_LOCATION="$HOME_VAGRANT/.virtualenvs/$KENV"

if [ ! -d "$VENV_LOCATION" ]; then
    install_info "Creating a new virtualenv"

	# If on a Vagrant system, check that the current user is 'vagrant'
    [ -d /home/vagrant ] && [ ! $(whoami) = "vagrant" ] && { echo "$0 must be run as user 'vagrant'"; exit 1; }

	cd $HOME_VAGRANT

	touch $PROFILE_PATH # In case the file doesn't exist

	# Ensure the profile is loaded (once).
	[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && . $PROFILE_PATH

	if [ -f "$VIRTUALENVS_KF" ]; then
		echo "Activating '$KENV' virtualenv"
		kobo_workon $KENV
	else
		echo "Creating a new virtualenv"
		kobo_mkvirtualenv $KENV
	fi
	deactivate

	echo ". $V_E/env_koboform" > $VENV_LOCATION/bin/postactivate

else
	install_info "Virtualenv already exists"
fi

