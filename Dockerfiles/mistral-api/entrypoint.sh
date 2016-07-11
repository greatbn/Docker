#! /bin/sh
/home/mistral/config.sh
mkdir /var/log/mistral/
mistral-db-manage --config-file /etc/mistral/mistral.conf upgrade head
mistral-db-manage --config-file /etc/mistral/mistral.conf populate
mistral-server --server api --config-file /etc/mistral/mistral.conf --log-file=/var/log/mistral/mistral-api.log
