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

RUN_ON_RELOAD_SCRIPT="$V_S/run_on_reload.sh"
RUN_ON_RELOAD_LOG=$V_L/run_on_reload.log

# Give the root user access to the `vagrant` user's virtual environments
ln -s $HOME_VAGRANT/.virtualenvs ~/.virtualenvs

# At boot, rotate the log for starting up KoBo, then start KoBo.
echo "$(crontab -l)" | grep "$RUN_ON_RELOAD_SCRIPT" || {
	crontab -l | { cat; echo "@reboot ([ -f $RUN_ON_RELOAD_LOG ] && mv $RUN_ON_RELOAD_LOG $RUN_ON_RELOAD_LOG.1) ; sh $RUN_ON_RELOAD_SCRIPT >> $RUN_ON_RELOAD_LOG 2>&1 &"; } | crontab -;
}

[ "$AUTOLAUNCH" = "1" ] && { sh "$RUN_ON_RELOAD_SCRIPT"; }
