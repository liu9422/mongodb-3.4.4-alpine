#!/bin/sh

if [ ! -d /data/db ]; then
    mkdir -p /data/db
fi

files=$(ls -A /data/db)

if [ -n "$files" ]; then
	echo "[i]MongoDB data directory already present, skipping creation"
else
	echo "[i]MongoDB data directory not found, creating initial DBs"
	/usr/bin/mongod --dbpath /data/db --nojournal &

	while ! nc -vz localhost 27017; do sleep 1; done

    if [ "$MONGODB_ADMIN_PASSWORD" = "" ]; then
        MONGODB_ADMIN_PASSWORD=admin
        echo "[i] MongoDB admin Password: $MONGODB_ADMIN_PASSWORD"
    fi

    mongo admin --eval "db.createUser({ user: 'admin', pwd: '${MONGODB_ADMIN_PASSWORD}', roles: [ { role: 'root', db: 'admin' } ] });"
    
	/usr/bin/mongod --dbpath /data/db --shutdown
fi

exec /usr/bin/mongod --dbpath /data/db --auth --bind_ip 0.0.0.0