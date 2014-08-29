#!/bin/bash

# ============================
# EXTEND ENVIRONMENT VARIABLES
. ./01_environment_vars.sh
# ============================

KENV="kc"
KENV_SHELL_EXTENDS="$V_E/env_koboform"
VENV_LOCATION="$HOME_VAGRANT/.virtualenvs/$KENV"

if [ ! -d "$VENV_LOCATION" ]; then
    install_info "Creating a new virtualenv"

	# [ $(whoami) = "vagrant" ] || { echo "create_virtualenv must be run as user 'vagrant'"; exit 1; }
	cd $HOME_VAGRANT

	touch $HOME_VAGRANT/.profile # In case the file doesn't exist
	if [ $(cat $HOME_VAGRANT/.profile | grep virtualenvwrapper | wc -l) = "0" ]; then
		echo "export WORKON_HOME='$HOME_VAGRANT/.virtualenvs'" >> $HOME_VAGRANT/.profile
		echo ". /usr/local/bin/virtualenvwrapper.sh" >> $HOME_VAGRANT/.profile
	fi

	if [ $(cat $HOME_VAGRANT/.profile | grep koborc | wc -l) = "0" ]; then
		echo "source $V_E/koborc" >> $HOME_VAGRANT/.profile
	fi

	if [ $(cat $HOME_VAGRANT/.profile | grep KOBO_PROFILE_LOADED | wc -l) = "0" ]; then
		echo 'export KOBO_PROFILE_LOADED="true"' >> $HOME_VAGRANT/.profile
	fi

	# Ensure the profile is loaded (once).
	[ ! ${KOBO_PROFILE_LOADED:-"false"} = "true" ] && [ . $HOME_VAGRANT/.profile ]

	if [ -d "$VENV_LOCATION" ]; then
		echo "Activating '$KENV' virtualenv"
		workon $KENV
	else
		echo "Creating a new virtualenv"
		mkvirtualenv $KENV
		# FIXME: This line needs to in the `postactivate` script regardless of whether we're creating the virtualenv or it already exists.
		[ $(cat $VENV_LOCATION/bin/postactivate | grep "source $V_E/env_kobocat" | wc -l) = "0" ] && echo "source $V_E/env_kobocat" >> $VENV_LOCATION/bin/postactivate
	fi

	# if [ -f "/usr/lib/i386-linux-gnu/libjpeg.so" ]; then
	# 	install_info "Symlink LibJPEG already created"
	# else
	# 	install_info "Symlink LibJPEG dependencies into virtualenv"
	# 	sudo ln -s /usr/lib/i386-linux-gnu/libjpeg.so $VIRTUAL_ENV/lib/python2.7/
	# 	sudo ln -s /usr/lib/i386-linux-gnu/libz.so $VIRTUAL_ENV/lib/python2.7/
	# fi

	deactivate

else
	install_info "Virtualenv already exists"
fi


