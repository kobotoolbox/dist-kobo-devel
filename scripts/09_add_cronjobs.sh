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

BOOT_LAUNCH_SCRIPT="$V_S/run_on_reload.sh"

echo "$(crontab -l)" | grep "$BOOT_LAUNCH_SCRIPT" || {
	crontab -l | { cat; echo "@reboot sh $BOOT_LAUNCH_SCRIPT &"; } | crontab -;
}

[ "$AUTOLAUNCH" = "1" ] && { sh "$BOOT_LAUNCH_SCRIPT"; }
