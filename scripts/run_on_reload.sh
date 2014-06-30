#!/bin/bash -u

LOGS="/vagrant/logs"
SCRIPTS="/vagrant/scripts"

# move the logs
[ -f "$LOGS/kobocat.log" ] && { mv "$LOGS/kobocat.log" "$LOGS/kobocat.log.1"; }
[ -f "$LOGS/koboform.log" ] && { mv "$LOGS/koboform.log" "$LOGS/koboform.log.1"; }

# start the servers
if [ -f "$SCRIPTS/run_kobocat.bash" ]; then
	bash "$SCRIPTS/run_kobocat.bash" >> "$LOGS/kobocat.log" 2>&1 &
fi

if [ -f "$SCRIPTS/run_koboform.bash" ]; then
	bash "$SCRIPTS/run_koboform.bash" >> "$LOGS/koboform.log" 2>&1 &
fi
