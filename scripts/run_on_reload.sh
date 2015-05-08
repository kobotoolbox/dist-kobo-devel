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

# FIXME: Sloppy wait for rsync completion so the server can be run using synced directories.
sleep 30

[ -f "$HOME/boot_launch_servers.log" ] && { mv "$HOME/boot_launch_servers.log" $V_L; }

# ensure logs dir exists
mkdir -p $V_L

# move the logs
[ -f "$V_L/kobocat.log" ] && { mv "$V_L/kobocat.log" "$V_L/kobocat.log.1"; }
[ -f "$V_L/koboform.log" ] && { mv "$V_L/koboform.log" "$V_L/koboform.log.1"; }
[ -f "$V_L/enketo.log" ] && { mv "$V_L/enketo.log" "$V_L/enketo.log.1"; }

# start the servers
if [ -f "$V_S/run_kobocat.bash" ]; then
	bash "$V_S/run_kobocat.bash" >> "$V_L/kobocat.log" 2>&1 &
fi

if [ -f "$V_S/run_koboform.bash" ]; then
	bash "$V_S/run_koboform.bash" >> "$V_L/koboform.log" 2>&1 &
fi

# Start PM2 to manage running Enketo if not already done.
# FIXME: Revert to using PM2 pending closure of https://github.com/kobotoolbox/enketo-express/issues/195
#sh -c "pm2 describe enketo || pm2 start $ENKETO_EXPRESS_REPO_DIR/app.js -n enketo" >> "$V_L/enketo.log" 2>&1 &
$( cd $ENKETO_EXPRESS_REPO_DIR && grunt develop >> $V_L/enketo.log 2>&1 ) &