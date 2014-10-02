#!/usr/bin/env sh

# scripts/02_installation_keys.sh

set -e

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

install_info "Install apt repository keys."

echo "KEYS >"

export DEBIAN_FRONTEND=noninteractive

# In Ubuntu releases starting with 12.10 (which is now EOL) `software-properties-common` replaces `python-software-properties` in providing `add-apt-repository`
UBUNTU_PACKAGE_NAME=$(cat /etc/issue.net |  awk '{x=2 ; if (substr($x,0,3) >= '13') {system("echo software-properties-common") } else {system("echo python-software-properties") }}')

sudo apt-get update
sudo apt-get install -y $UBUNTU_PACKAGE_NAME

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

sudo add-apt-repository -y ppa:chris-lea/node.js

echo "KEYS > All keys added '$VHOME'"
touch $HOME_VAGRANT/.mark_keys_added

