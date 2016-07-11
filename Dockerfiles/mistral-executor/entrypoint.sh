#! /bin/sh
/home/mistral/config.sh
mkdir /var/log/mistral/

mistral-server --server executor --config-file /etc/mistral/mistral.conf --log-file=/var/log/mistral/mistral-executor.log
