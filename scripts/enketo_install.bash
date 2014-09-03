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
export ENKETO_EXPRESS_UPDATE_REPO="false"

# FIXME: Use the following line once the `relocatable-bootstrap` branch has been merged into Enketo Express's `master`.
#git clone https://github.com/kobotoolbox/enketo-express.git $ENKETO_EXPRESS_REPO_DIR
git clone https://github.com/kobotoolbox/enketo-express.git -b relocatable-bootstrap --single-branch $ENKETO_EXPRESS_REPO_DIR

cd $ENKETO_EXPRESS_REPO_DIR
sudo -E sh $ENKETO_EXPRESS_REPO_DIR/setup/bootstrap.sh # `-E` option preserves calling shell's environment variables.

