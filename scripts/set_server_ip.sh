#/bin/sh

set -e

if [ $# = "0" ]; then
    echo "must supply an argument to $0"
    exit 1
fi

echo "export SERVER_IP='$1'" > $V_E/SERVER_IP.sh

sh $V_S/enketo/update_enketo_configs.sh
