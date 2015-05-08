#!/usr/bin/env bash

# scripts/enketo_install.bash

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

cd $HOME_VAGRANT

[ -d "$ENKETO_EXPRESS_REPO_DIR" ] || git clone https://github.com/kobotoolbox/enketo-express.git $ENKETO_EXPRESS_REPO_DIR
cd $ENKETO_EXPRESS_REPO_DIR

# Edit the Enketo Express configuration JSON so the `server url` field is set to the local KoBoCat server.
CONFIG_FILE_PATH="$ENKETO_EXPRESS_REPO_DIR/config/config.json"
[ -f $CONFIG_FILE_PATH ] || echo "{}" >> $CONFIG_FILE_PATH
python -c "import json;f=open('$CONFIG_FILE_PATH');config=json.loads(f.read());config['offline enabled']='true';config.setdefault('linked form and data server',{})['server url']='$KOBOCAT_URL';f2=open('$CONFIG_FILE_PATH~','w');f2.write(json.dumps(config, indent=4))"
mv $CONFIG_FILE_PATH~ $CONFIG_FILE_PATH

# Install and run Enketo Express.
sudo -E sh $ENKETO_EXPRESS_REPO_DIR/setup/bootstrap.sh
