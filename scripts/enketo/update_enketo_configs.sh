#!/bin/sh

echo 'update enketo configs'

CONFIG_FILE_PATH="$ENKETO_EXPRESS_REPO_DIR/config/config.json"

if [ -f "$CONFIG_FILE_PATH" ]; then
	# creates a modified version of the config file with 'server url' parameter set to
	# value of $KOBOCAT_URL and 'port' set to $ENKETO_EXPRESS_SERVER_PORT
	python -c "import json;f=open('$CONFIG_FILE_PATH');config=json.loads(f.read());config['port']='$ENKETO_EXPRESS_SERVER_PORT';config['linked form and data server']['server url']='$KOBOCAT_URL';print json.dumps(config, indent=4)" > $CONFIG_FILE_PATH~
	[ "$?" = "0" ] && mv $CONFIG_FILE_PATH~ $CONFIG_FILE_PATH
else
	echo "Could not find enketo config file at this path: '$CONFIG_FILE_PATH'"
	exit 1
fi
