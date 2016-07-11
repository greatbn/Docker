#!/bin/sh
/home/config.sh
adduser -S keystone
addgroup -S keystone
mkdir /var/log/keystone/
touch /var/log/keystone/keystone-manage.log 
keystone-manage db_sync
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone

echo "[i] Starting daemon..."
# run apache httpd daemon
exec /usr/sbin/apachectl -DFOREGROUND;
# display logs
tail -f /var/log/apache2/*
