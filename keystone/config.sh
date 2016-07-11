#!/bin/sh
#default value if not set

KEYSTONE_DBADDR=${KEYSTONE_DBADDR-mysql}
sed -i 's/ADMIN_TOKEN/'$ADMIN_TOKEN'/g' /etc/keystone/keystone.conf
sed -i 's/KEYSTONE_DBUSER/'$KEYSTONE_DBUSER'/g' /etc/keystone/keystone.conf
sed -i 's/KEYSTONE_DBPASS/'$KEYSTONE_DBPASS'/g' /etc/keystone/keystone.conf
sed -i 's/KEYSTONE_DBADDR/'$KEYSTONE_DBADDR'/g' /etc/keystone/keystone.conf
sed -i 's/KEYSTONE_DBNAME/'$KEYSTONE_DBNAME'/g' /etc/keystone/keystone.conf
sed -i 's/CONTROLLER_ADDR/'$CONTROLLER_ADDR'/g' /etc/keystone/keystone.conf
