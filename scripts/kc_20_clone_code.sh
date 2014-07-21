#!/bin/sh -u

# scripts/kc_20_clone_code.sh

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

install_info "5 clone_code"

# pull if directory exists
# [ -d "$KOBOCAT_PATH" ] && { cd $KOBOCAT_PATH; git pull origin $KOBOCAT_BRANCH; }
[ -d "$KOBOCAT_PATH" ] || { git clone $KOBOCAT_REPO $KOBOCAT_PATH -b $KOBOCAT_BRANCH; }

# [ -d "$KOBOCAT_TEMPLATES_PATH" ] && { cd $KOBOCAT_PATH; git pull origin $KOBOCAT_TEMPLATES_BRANCH; }
[ -d "$KOBOCAT_TEMPLATES_PATH" ] || { git clone $KOBOCAT_TEMPLATES_REPO $KOBOCAT_TEMPLATES_PATH -b $KOBOCAT_TEMPLATES_BRANCH; }

ONA_KCSETS="$V_H/kobocat/onadata/settings/kobocat_settings.py"
[ ! -f "$ONA_KCSETS" ] && { ln -s $V_H/configs/kobocat_settings.py $ONA_KCSETS; }

echo "code cloned"
exit