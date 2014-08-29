#!/bin/bash -u

# ============================
# EXTEND ENVIRONMENT VARIABLES
. ./01_environment_vars.sh
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
