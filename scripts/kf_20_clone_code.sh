#!/usr/bin/env sh

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

install_info "KF clone code"

if [ -n "$KOBO_RESET_REPOS" ]; then
	# if node_modules exists, then move it to a path where it won't be deleted
	[ -d "$KOBOFORM_PATH/node_modules" ] && mv "$KOBOFORM_PATH/../koboform_node_modules"
	rm -rf $KOBOFORM_PATH
fi

# If on a Vagrant system, check that the current user is 'vagrant'
[ -d /home/vagrant ] && [ ! $(whoami) = "vagrant" ] && { echo "$0 must be run as user 'vagrant'"; exit 1; }

[ -d "$KOBOFORM_PATH" ] || { git clone $KOBOFORM_REPO $KOBOFORM_PATH -b $KOBOFORM_BRANCH; }

# moving node_modules back to its previous path
[ -d "$KOBOFORM_PATH/../koboform_node_modules" ] && mv "$KOBOFORM_PATH/../koboform_node_modules" "$KOBOFORM_PATH/node_modules"

# return success if repo path exists
[ -d "$KOBOFORM_PATH/.git" ]
exit $?