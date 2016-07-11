#!/bin/bash

fileconfig=/etc/manila/manila.conf
crudini --set $fileconfig DEFAULT host
crudini --set $fileconfig DEFAULT rpc_backend rabbit
crudini --set $fileconfig DEFAULT auth_strategy keystone
crudini --set $fileconfig DEFAULT default_share_type default_share_type
crudini --set $fileconfig DEFAULT rootwrap_config /etc/manila/rootwrap.conf
crudini --set $fileconfig DEFAULT my_ip `ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}' | sed '1!d'`
crudini --set $fileconfig database connection mysql+pymysql://$MANILA_DBUSER:$MANILA_DBPASS@$DB_IP_ADDR/$MANILA_DBNAME
crudini --set $fileconfig oslo_messaging_rabbit rabbit_host $CONTROLLER_ADDR
crudini --set $fileconfig oslo_messaging_rabbit rabbit_userid $RABBIT_USERID
crudini --set $fileconfig oslo_messaging_rabbit rabbit_password $RABBIT_PASS
crudini --set $fileconfig keystone_authtoken auth_uri http://$CONTROLLER_ADDR:5000
crudini --set $fileconfig keystone_authtoken auth_url http://$CONTROLLER_ADDR:35357
crudini --set $fileconfig keystone_authtoken memcached_servers $CONTROLLER_ADDR:11211
crudini --set $fileconfig keystone_authtoken auth_type password
crudini --set $fileconfig keystone_authtoken project_domain_name $PROJECT_DOMAIN_NAME
crudini --set $fileconfig keystone_authtoken user_domain_name $USER_DOMAIN_NAME
crudini --set $fileconfig keystone_authtoken project_name $PROJECT_NAME
crudini --set $fileconfig keystone_authtoken username $USER_MANILA
crudini --set $fileconfig keystone_authtoken password $MANILA_PASS
crudini --set $fileconfig oslo_concurrency lock_path /var/lib/manila/tmp
