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

# enabling journaling as described here: http://docs.mongodb.org/v2.4/reference/configuration-options/#journal
if [ $(cat /etc/mongod.conf | egrep "^journal= true" | wc -l) = "0" ]; then
	sudo bash -c 'echo -e "\n# KoBoCat: Ensure journaling is enabled.\njournal= true" >> /etc/mongod.conf'
fi
if [ $(cat /etc/mongod.conf | egrep "^smallfiles= true" | wc -l) = "0" ]; then
	sudo bash -c 'echo -e "\n# KoBoCat: Ensure journaling uses smallfiles.\nsmallfiles= true" >> /etc/mongod.conf'
fi

# Bring the configuration change into effect.
sudo service mongod restart

