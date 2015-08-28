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

cd $ENKETO_EXPRESS_REPO_DIR

# Update Enketo's config. in case the IP address setting has changed since last run.
sh $V_S/enketo/update_enketo_configs.sh

if [ ! -f subsequent_run ]; then
	# Execute directly using NPM the first time as a workaround for
	# https://github.com/kobotoolbox/enketo-express/issues/228
	touch subsequent_run
	npm start
else
	# On subsequent runs, start PM2 to manage running Enketo if not already done.
	pm2 describe enketo || pm2 start $ENKETO_EXPRESS_REPO_DIR/app.js -n enketo
fi