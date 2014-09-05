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

export ENKETO_EXPRESS_REPO_DIR="$HOME_VAGRANT/enketo-express"
echo "export ENKETO_EXPRESS_REPO_DIR=\"$ENKETO_EXPRESS_REPO_DIR\"" >> $PROFILE_PATH

export ENKETO_EXPRESS_UPDATE_REPO="false"

git clone https://github.com/kobotoolbox/enketo-express.git $ENKETO_EXPRESS_REPO_DIR

# Install Enketo Express
cd $ENKETO_EXPRESS_REPO_DIR
sudo -E sh $ENKETO_EXPRESS_REPO_DIR/setup/bootstrap.sh # `-E` option preserves calling shell's environment variables.

# Record the local server's existence for use with KoBoForm.
echo 'export ENKETO_SERVER="localhost"' >> $PROFILE_PATH
echo 'export ENKETO_PREVIEW_URI="/preview"' >> $PROFILE_PATH

echo 'export KOBOFORM_PREVIEW_SERVER="localhost:8000"' >> $PROFILE_PATH

# KoBoCat
echo 'export ENKETO_URL="localhost"' >> $PROFILE_PATH

