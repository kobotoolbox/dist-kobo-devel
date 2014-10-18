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

KENV="kc"
KENV_SHELL_EXTENDS="$V_E/env_koboform"
VENV_LOCATION="$HOME_VAGRANT/.virtualenvs/$KENV"

if [ ! -d "$VENV_LOCATION" ]; then
    install_info "Creating a new virtualenv"

	# If on a Vagrant system, check that the current user is 'vagrant'
    [ -d /home/vagrant ] && [ ! $(whoami) = "vagrant" ] && { echo "$0 must be run as user 'vagrant'"; exit 1; }

	cd $HOME_VAGRANT

	touch $PROFILE_PATH # In case the file doesn't exist

	if [ $(cat $PROFILE_PATH | grep KOBO_PROFILE_LOADED | wc -l) = "0" ]; then
		echo 'export KOBO_PROFILE_LOADED="true"' >> $PROFILE_PATH
	fi

	# Ensure the profile is loaded (once).
	[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && . $PROFILE_PATH

	if [ -f "$VIRTUALENVS_KC" ]; then
		echo "Activating '$KENV' virtualenv"
		kobo_workon kc
	else
		echo "Creating a new virtualenv"
		kobo_mkvirtualenv $KENV
	fi

	# if [ -f "/usr/lib/i386-linux-gnu/libjpeg.so" ]; then
	# 	install_info "Symlink LibJPEG already created"
	# else
	# 	install_info "Symlink LibJPEG dependencies into virtualenv"
	# 	sudo ln -s /usr/lib/i386-linux-gnu/libjpeg.so $VIRTUAL_ENV/lib/python2.7/
	# 	sudo ln -s /usr/lib/i386-linux-gnu/libz.so $VIRTUAL_ENV/lib/python2.7/
	# fi

	deactivate

	echo ". $V_E/env_kobocat" > $VENV_LOCATION/bin/postactivate
else
	install_info "Virtualenv already exists"
fi


