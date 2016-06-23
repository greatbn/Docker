#!/bin/sh
#default value if not set

MISTRAL_DBADDR=${MISTRAL_DBADDR-mysql}
RABBIT_ADDR=${RABBIT_ADDR-rabbitmq}

sed -i 's/MISTRAL_DBUSER/'$MISTRAL_DBUSER'/g' /etc/mistral/mistral.conf
sed -i 's/MISTRAL_DBPASS/'$MISTRAL_DBPASS'/g' /etc/mistral/mistral.conf
sed -i 's/MISTRAL_DBADDR/'$MISTRAL_DBADDR'/g' /etc/mistral/mistral.conf
sed -i 's/MISTRAL_DBNAME/'$MISTRAL_DBNAME'/g' /etc/mistral/mistral.conf
sed -i 's/CONTROLLER_ADDR/'$CONTROLLER_ADDR'/g' /etc/mistral/mistral.conf
sed -i 's/MISTRAL_USER/'$MISTRAL_USER'/g' /etc/mistral/mistral.conf
sed -i 's/MISTRAL_PASS/'$MISTRAL_PASS'/g' /etc/mistral/mistral.conf
sed -i 's/RABBIT_ADDR/'$RABBIT_ADDR'/g' /etc/mistral/mistral.conf
sed -i 's/RABBIT_USER/'$RABBIT_USER'/g' /etc/mistral/mistral.conf
sed -i 's/RABBIT_PASS/'$RABBIT_PASS'/g' /etc/mistral/mistral.conf
