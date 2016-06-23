#! /bin/sh
/home/mistral/config.sh
mkdir /var/log/mistral/

mistral-server --server engine --config-file /etc/mistral/mistral.conf --log-file=/var/log/mistral/mistral-engine.log
