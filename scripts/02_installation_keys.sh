#!/bin/sh

# scripts/02_installation_keys.sh

set -e

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================


echo "KEYS >"

export DEBIAN_FRONTEND=noninteractive

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

sudo add-apt-repository -y ppa:chris-lea/node.js

echo "KEYS > All keys added '$VHOME'"
touch $HOME/.mark_keys_added

