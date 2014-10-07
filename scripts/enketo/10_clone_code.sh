#!/bin/sh

if [ -d "$ENKETO_EXPRESS_REPO_DIR" ]; then
	echo "enketo-express code is already cloned"
else
	git clone https://github.com/kobotoolbox/enketo-express.git $ENKETO_EXPRESS_REPO_DIR
fi

cd $ENKETO_EXPRESS_REPO_DIR

echo 'ensuring submodules are updated'
git submodule update --init --recursive

sh $V_S/enketo/update_enketo_configs.sh
