FROM python:2.7.12-alpine
MAINTAINER Sa Phi <saphi070@gmail.com>
# Install package dependencies
RUN apk add --no-cache --update py-pip python3 python-dev python3-dev build-base git musl-dev libxml2-dev \
  libxslt-dev libffi-dev openssl-dev linux-headers libldap  libsasl libffi-dev libxslt-dev \
  && rm -rf /var/cache/apk/*


#clone source code
WORKDIR /home
RUN git clone https://github.com/openstack/keystone.git

#install python library
WORKDIR /home/keystone
RUN pip install .

RUN pip install pymysql

#install
RUN mkdir /etc/keystone && cp -R etc/logging.conf.sample /etc/keystone/logging.conf && \
    cp etc/keystone-paste.ini etc/policy.json etc/default_catalog.templates /etc/keystone/ 
COPY keystone.conf /etc/keystone/

#install apache2
RUN apk add --no-cache --update apache2 apache2-mod-wsgi apache2-utils patchwork-apache2-wsgi
COPY wsgi-keystone.conf /etc/apache2/conf.d/

COPY config.sh entrypoint.sh /home/
RUN chmod a+x /home/*
RUN rm -r /home/keystone
EXPOSE 5000
EXPOSE 35357
ENTRYPOINT ["/home/entrypoint.sh"]
