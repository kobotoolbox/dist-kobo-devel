if [ ! -f "/etc/redis/redis-enketo-main.conf" ]; then
	echo 'copying enketo redis conf...'
	rm -f /etc/redis/redis.conf
	cp -f $ENKETO_EXPRESS_REPO_DIR/setup/redis/conf/redis-enketo-main.conf /etc/redis/
	cp -f $ENKETO_EXPRESS_REPO_DIR/setup/redis/conf/redis-enketo-cache.conf /etc/redis/
	chown redis:redis /var/lib/redis/
fi

if [ ! -f "/etc/init/redis-server-enketo-main.conf" ]; then
	echo 'copying enketo redis-server configs...'
	rm -f /etc/init/redis-server.conf
	cp -f $ENKETO_EXPRESS_REPO_DIR/setup/redis/init/redis-server-enketo-main.conf /etc/init/
	cp -f $ENKETO_EXPRESS_REPO_DIR/setup/redis/init/redis-server-enketo-cache.conf /etc/init/
fi

rm -f /var/lib/redis/redis.rdb

if [ ! -f "/var/lib/redis/enketo-main.rdb" ]; then 
	echo 'copying enketo default redis db...'
	cp -f $ENKETO_EXPRESS_REPO_DIR/setup/redis/enketo-main.rdb /var/lib/redis/
	chown redis:redis /var/lib/redis/enketo-main.rdb
	chmod 660 /var/lib/redis/enketo-main.rdb
fi

safe_start_service () {
	# avoid returning an error code if the service is already started

	START_MSG="$(service $1 start 2>&1)"
	echo "$START_MSG" | grep "already" > /dev/null
	if [ $? = "1" ]; then
		echo "$START_MSG" | grep "start/running" > /dev/null
		if [ $? = "1" ]; then
			exit 1 #!!!
		fi
	fi
	echo "$START_MSG"
}

safe_start_service "redis-server-enketo-main"
safe_start_service "redis-server-enketo-cache"
