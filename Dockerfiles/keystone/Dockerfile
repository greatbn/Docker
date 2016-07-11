FROM ubuntu:16.04
RUN apt-get install -y python python-pip python-dev python3-dev libxml2-dev libxslt1-dev \
    libsasl2-dev libsqlite3-dev libssl-dev libldap2-dev libffi-dev apache2 libapache2-mod-wsgi

RUN pip install pymysql

clone source code
WORKDIR /home
RUN git clone https://github.com/openstack/keystone.git -b stable/mitaka

WORKDIR /home/keystone
RUN pip install .

#install
RUN mkdir /etc/keystone && cp -R etc/logging.conf.sample /etc/keystone/logging.conf && \
    cp etc/keystone-paste.ini etc/policy.json etc/default_catalog.templates /etc/keystone/
COPY keystone.conf /etc/keystone/
RUN cp httpd/wsgi-keystone.conf /etc/apache2/conf.d/

COPY config.sh entrypoint.sh /home/
RUN chmod a+x /home/*

RUN rm -r /home/keystone
EXPOSE 5000
EXPOSE 35357
ENTRYPOINT ["/home/entrypoint.sh"]
