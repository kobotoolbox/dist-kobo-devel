#!/usr/bin/env sh

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

install_info "Adding cron jobs."

BOOT_LAUNCH_SCRIPT="$HOME_VAGRANT/boot_launch_servers.sh"
cp $V_S/X_boot_launch_servers.sh $BOOT_LAUNCH_SCRIPT

if [ $( crontab -l | grep boot_launch | wc -l ) = "0" ]; then
	crontab -l | { cat; echo "@reboot sh $BOOT_LAUNCH_SCRIPT &"; } | crontab -
	install_info "crontab added"
	bash $V_S/run_on_reload.sh
else
	echo "crontab already added"
fi

