#!/bin/sh -u

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

KENV="kf"
KENV_SHELL_EXTENDS="/vagrant/env/env_koboform"
VENV_LOCATION="/home/vagrant/.virtualenvs/$KENV"

if [ ! -d "$VENV_LOCATION" ]; then
    install_info "Creating a new virtualenv"

	# [ $(whoami) = "vagrant" ] || { echo "create_virtualenv must be run as user 'vagrant'"; exit 1; }
	cd /home/vagrant

	if [ $(cat /home/vagrant/.profile | grep virtualenvwrapper | wc -l) = "0" ]; then
		echo 'export "WORKON_HOME=/home/vagrant/.virtualenvs"' >> /home/vagrant/.profile
		echo ". /usr/local/bin/virtualenvwrapper.sh" >> /home/vagrant/.profile
	fi

	if [ $(cat /home/vagrant/.profile | grep koborc | wc -l) = "0" ]; then
		echo "source /vagrant/env/koborc" >> /home/vagrant/.profile
	fi

	. /home/vagrant/.profile

	if [ -d "/home/vagrant/.virtualenvs/$KENV" ]; then
		echo "Activating '$KENV' virtualenv"
		workon $KENV
	else
		echo "Creating a new virtualenv"
		mkvirtualenv $KENV
		echo "source $KENV_SHELL_EXTENDS" >> /home/vagrant/.virtualenvs/$KENV/bin/postactivate
	fi

	deactivate

else
	install_info "Virtualenv already exists"
fi
