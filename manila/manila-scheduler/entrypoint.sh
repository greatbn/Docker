#! /bin/bash
/home/manila/config.sh
mkdir /var/log/manila/
manila-scheduler --log-file=/var/log/manila/manila-scheduler.log --config-file=/etc/manila/manila.conf
