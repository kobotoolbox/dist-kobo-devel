#!/bin/bash -u

# scripts/kc_10_virtualenvs.sh

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

VENV_LOCATION="/home/vagrant/.virtualenvs/kc"

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

	if [ -d "/home/vagrant/.virtualenvs/kc" ]; then
		echo "Activating KC virtualenv"
		workon kc
	else
		echo "Creating a new virtualenv"
		mkvirtualenv kc
		echo "source /vagrant/env/env_kobocat" >> /home/vagrant/.virtualenvs/kc/bin/postactivate
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
