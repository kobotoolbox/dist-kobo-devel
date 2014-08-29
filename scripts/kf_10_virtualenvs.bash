#!/bin/bash

# ============================
# EXTEND ENVIRONMENT VARIABLES
. ./01_environment_vars.sh
# ============================

KENV="kf"
KENV_SHELL_EXTENDS="$V_E/env_koboform"
VENV_LOCATION="$HOME_VAGRANT/.virtualenvs/$KENV"

if [ ! -d "$VENV_LOCATION" ]; then
    install_info "Creating a new virtualenv"

	# [ $(whoami) = "vagrant" ] || { echo "create_virtualenv must be run as user 'vagrant'"; exit 1; }
	cd $HOME_VAGRANT

	touch $HOME_VAGRANT/.profile # In case the file doesn't exist
	if [ $(cat $HOME_VAGRANT/.profile | grep virtualenvwrapper | wc -l) = "0" ]; then
		echo 'export WORKON_HOME="$HOME_VAGRANT/.virtualenvs"' >> $HOME_VAGRANT/.profile
		echo ". /usr/local/bin/virtualenvwrapper.sh" >> $HOME_VAGRANT/.profile
	fi

	if [ $(cat $HOME_VAGRANT/.profile | grep koborc | wc -l) = "0" ]; then
		echo "source $V_E/koborc" >> $HOME_VAGRANT/.profile
	fi

	# Ensure the profile is loaded (once).
	[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && [ . $HOME_VAGRANT/.profile]

	if [ -d "$VENV_LOCATION" ]; then
		echo "Activating '$KENV' virtualenv"
		workon $KENV
	else
		echo "Creating a new virtualenv"
		mkvirtualenv $KENV
		echo "source $V_E/env_koboform" >> $VENV_LOCATION/bin/postactivate
	fi

	deactivate

else
	install_info "Virtualenv already exists"
fi
