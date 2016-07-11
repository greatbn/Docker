#!/bin/sh
/home/config.sh
#adduser -S keystone
#addgroup -S keystone
useradd --home-dir /var/lib/keystone --create-home --system --shell /bin/false keystone

mkdir /var/log/keystone/
keystone-manage db_sync
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
echo   "ServerName "`getent hosts ${1:-$HOSTNAME} | awk '{print $1}'` >>  /etc/apache2/apache2.conf
chown -R keystone:keystone /etc/keystone/*
chown keystone:keystone /etc/keystone
chown -R keystone:keystone /var/log/keystone
echo "[i] Starting daemon..."
# run apache httpd daemon
exec /usr/sbin/apachectl -DFOREGROUND;
# display logs
tail -f /var/log/apache2/*
