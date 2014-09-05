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
echo ''>> $PROFILE_PATH
echo "export ENKETO_EXPRESS_REPO_DIR=\"$ENKETO_EXPRESS_REPO_DIR\"" >> $PROFILE_PATH

export ENKETO_EXPRESS_UPDATE_REPO="false"

git clone https://github.com/kobotoolbox/enketo-express.git $ENKETO_EXPRESS_REPO_DIR

# Install Enketo Express
cd $ENKETO_EXPRESS_REPO_DIR
sudo -E sh $ENKETO_EXPRESS_REPO_DIR/setup/bootstrap.sh # `-E` option preserves calling shell's environment variables.

# FIXME: Need to manipulate '$ENKETO_EXPRESS_REPO_DIR/config/config.json' to use `"server url": "localhost:8001"`.

# Record the local server's existence for use with KoBoForm.
echo 'export ENKETO_SERVER="http://localhost:8005"' >> $PROFILE_PATH
echo 'export ENKETO_PREVIEW_URI="/preview"' >> $PROFILE_PATH

# KoBoCat
echo 'export ENKETO_URL="http://localhost:8005"' >> $PROFILE_PATH
echo 'export ENKETO_API_URL_PARTIAL="/api/v1"' >> $PROFILE_PATH
echo 'export ENKETO_PREVIEW_URL_PARTIAL="/preview"' >> $PROFILE_PATH
# FIXME: Should pull directly from local 'enketo-express/config/config.json' instead of hard coding (synergy w/ above FIXME).
echo 'export ENKETO_API_TOKEN="enketorules"' >> $PROFILE_PATH

