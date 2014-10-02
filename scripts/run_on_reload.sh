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

if [ "$AUTOLAUNCH" = "0" ]; then
	echo "Autolaunch prevented"
	exit;
fi

# ensure logs dir exists
mkdir -p $V_L

# move the logs
[ -f "$V_L/kobocat.log" ] && { mv "$V_L/kobocat.log" "$V_L/kobocat.log.1"; }
[ -f "$V_L/koboform.log" ] && { mv "$V_L/koboform.log" "$V_L/koboform.log.1"; }

# start the servers
if [ -f "$V_S/run_kobocat.bash" ]; then
	bash "$V_S/run_kobocat.bash" >> "$V_L/kobocat.log" 2>&1 &
fi

if [ -f "$V_S/run_koboform.bash" ]; then
	bash "$V_S/run_koboform.bash" >> "$V_L/koboform.log" 2>&1 &
fi

# Start PM2 to manage running Enketo if not already done.
sudo sh -E -c "cd $ENKETO_EXPRESS_REPO_DIR && . env/bin/activate && pm2 describe enketo || pm2 start app.js -n enketo"

