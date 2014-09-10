#!/usr/bin/env sh

# scripts/kc_20_clone_code.sh

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

install_info "Cloning KoBoCat code."

# pull if directory exists
# [ -d "$KOBOCAT_PATH" ] && { cd $KOBOCAT_PATH; git pull origin $KOBOCAT_BRANCH; }
[ -d "$KOBOCAT_PATH" ] || { git clone --depth 1 $KOBOCAT_REPO $KOBOCAT_PATH -b $KOBOCAT_BRANCH; }

# [ -d "$KOBOCAT_TEMPLATES_PATH" ] && { cd $KOBOCAT_PATH; git pull origin $KOBOCAT_TEMPLATES_BRANCH; }
[ -d "$KOBOCAT_TEMPLATES_PATH" ] || { git clone --depth 1 $KOBOCAT_TEMPLATES_REPO $KOBOCAT_TEMPLATES_PATH -b $KOBOCAT_TEMPLATES_BRANCH; }

ONA_KCSETS="$KOBOCAT_PATH/onadata/settings/kobocat_settings.py"
[ ! -f "$ONA_KCSETS" ] && { ln -s $V_R/configs/kobocat_settings.py $ONA_KCSETS; }

echo "code cloned"
exit
