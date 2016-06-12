#! /bin/bash
/home/manila/config.sh
mkdir /var/log/manila/
if [$BOOTSTRAP == "True"]
then
  su -s /bin/sh -c "manila-manage db sync" manila
fi
manila-api --log-file=/var/log/manila/manila-api.log --config-file=/etc/manila/manila.conf
