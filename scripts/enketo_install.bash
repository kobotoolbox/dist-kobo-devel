#!/usr/bin/env bash

# scripts/enketo_install.bash

set -e

# ============================
# EXTEND ENVIRONMENT VARIABLES
if [ -d /home/vagrant ]; then
    SCRIPT_DIR=/vagrant/scripts
else
    THIS_SCRIPT_PATH=$(readlink -f "$0")
    SCRIPT_DIR=$(dirname "$THIS_SCRIPT_PATH")
fi
. $SCRIPT_DIR/01_environment_vars.sh
# ============================

cd $HOME_VAGRANT

git clone https://github.com/kobotoolbox/enketo-express.git $ENKETO_EXPRESS_REPO_DIR
cd $ENKETO_EXPRESS_REPO_DIR
# FIXME: Remove this upon merge https://github.com/kobotoolbox/enketo-express/pull/71
git checkout allow-nodeenv

# Install Enketo Express
sudo -E sh $ENKETO_EXPRESS_REPO_DIR/setup/bootstrap.sh # `-E` option preserves calling shell's environment variables.

# Edit the Enketo Express configuration JSON so the `server url` field is set to the local KoBoCat server.
sed -r -i 's/("server url":.*)".+"/\1 "http://localhost:8001"/' $ENKETO_EXPRESS_REPO_DIR/config/config.json

