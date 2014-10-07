#!/usr/bin/env sh

set -e

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
[ -n "$KOBO_SKIP_INSTALL" ] && exit 0


install_info "Adding cron jobs."

BOOT_LAUNCH_SCRIPT="$HOME_VAGRANT/boot_launch_servers.sh"
cp $V_S/X_boot_launch_servers.sh $BOOT_LAUNCH_SCRIPT

existing_crontab="$(crontab -l)" 2> /dev/null
if [ $(echo $existing_crontab | grep boot_launch | wc -l ) = "0" ]; then
	echo $existing_crontab | { cat; echo "@reboot sh $BOOT_LAUNCH_SCRIPT &"; } | crontab -
	install_info "crontab added: '@reboot sh $BOOT_LAUNCH_SCRIPT &'"
	sh $BOOT_LAUNCH_SCRIPT
else
	echo "crontab already added"
fi
