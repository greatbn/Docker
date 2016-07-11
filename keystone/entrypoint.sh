#!/bin/sh
/home/config.sh
adduser -S keystone
addgroup -S keystone
mkdir /var/log/keystone/
touch /var/log/keystone/keystone-manage.log
keystone-manage db_sync
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
chown -R keystone:keystone /usr/local/bin/keystone*
chown -R apache:apache /var/log/keystone
chmod 755 /usr/local/bin/keystone*
#usermod -a -G keystone apache
echo   "ServerName "`getent hosts ${1:-$HOSTNAME} | awk '{print $1}'` >> /etc/apache2/httpd.conf
mkdir /run/apache2
echo "[i] Starting daemon..."
# run apache httpd daemon
exec /usr/sbin/apachectl -DFOREGROUND;
# display logs
tail -f /var/log/apache2/*
