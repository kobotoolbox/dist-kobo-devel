#!/bin/sh

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

BOOT_LAUNCH_SCRIPT="$HOME_VAGRANT/boot_launch_servers.sh"
cp $V_S/X_boot_launch_servers.sh $BOOT_LAUNCH_SCRIPT

if [ $( crontab -l | grep boot_launch | wc -l ) = "0" ]; then
	crontab -l | { cat; echo "@reboot sh $BOOT_LAUNCH_SCRIPT &"; } | crontab -
	install_info "crontab added"
	install_info "launching server (see 'logs' if there is a problem)"
	bash $V_S/run_on_reload.sh
	install_info "servers should be running on ports 8000 and 8001"
else
	echo "crontab already added"
fi

