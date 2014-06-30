#!/bin/sh
BOOT_LAUNCH_SCRIPT="/home/vagrant/boot_launch_servers.sh"
cp /vagrant/scripts/X_boot_launch_servers.sh $BOOT_LAUNCH_SCRIPT

if [ $( crontab -l | grep boot_launch | wc -l ) = "0" ]; then
	crontab -l | { cat; echo "@reboot sh $BOOT_LAUNCH_SCRIPT &"; } | crontab -
else
	echo "crontab already added"
fi

