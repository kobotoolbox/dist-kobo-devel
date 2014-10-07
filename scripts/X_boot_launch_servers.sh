#!/usr/bin/env sh

# You probably don't want to edit this file.
# It just launches a script in the vagrant directory when it is made available to the OS
# (if it's made available in the first 60 seconds after startup)

# To be run with the crontab
# @reboot sh /path/to/boot_launch_servers.sh

# identical to 01_env...
V_S="/home/vagrant/scripts"

CRONLOG_LOGFILE="$HOME/boot_launch_servers.log"

# clean out the log
mkdir -p $CRONLOG_DIR
[ -f "$CRONLOG_LOGFILE" ] && { mv "$CRONLOG_LOGFILE" "$CRONLOG_LOGFILE.1"; }

VAGRANT_IS_UP_DIR="$V_S"
VAGRANT_IS_UP_SCRIPT="$V_S/run_on_reload.sh"
WAIT_TIME_AFTER_VAGRANT_IS_UP=1

vagrant_is_up() {
	if [ -f "$VAGRANT_IS_UP_SCRIPT" ]; then
		sh "$VAGRANT_IS_UP_SCRIPT" >> $CRONLOG_LOGFILE 2>&1 &
	else
		echo "Could not execute '$VAGRANT_IS_UP_SCRIPT'" >> $CRONLOG_LOGFILE
		exit 1
	fi
	exit
}

check_for_vagrant_up() {
	if [ -d "$VAGRANT_IS_UP_DIR" ]; then
		sleep $WAIT_TIME_AFTER_VAGRANT_IS_UP;
		vagrant_is_up
		exit;
	fi
}

echo "server has booted" >> $CRONLOG_LOGFILE
date >> $CRONLOG_LOGFILE

# wait $max seconds before giving up on waiting for vagrant shared folders to appear
max=60
for i in `seq 2 $max`
do
	check_for_vagrant_up
	echo "After $i seconds, '$VAGRANT_IS_UP_DIR' has not appeared" >> $CRONLOG_LOGFILE
	sleep 1
done

echo "Max wait time exceeded. Server could not be launched: $0" >> $CRONLOG_LOGFILE
exit 1;
