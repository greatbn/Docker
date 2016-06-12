#! /bin/bash
/home/manila/config.sh
mkdir /var/log/manila/
su -s /bin/sh -c "manila-manage db sync" manila
manila-api --log-file=/var/log/manila/manila-api.log --config-file=/etc/manila/manila.conf
