FROM python:2.7.11-alpine
MAINTAINER Sa Phi <saphi070@gmail.com>
# Install package dependencies
RUN apk add --update python py-pip  python-dev build-base git gcc musl-dev libxml2-dev \
  libxslt-dev libffi-dev openssl-dev linux-headers\
  && rm -rf /var/cache/apk/*

#clone source code
WORKDIR /home
RUN git clone https://github.com/openstack/manila.git -b stable/mitaka

#install python library
WORKDIR /home/manila
RUN pip install -r requirements.txt
RUN pip install pymysql python-memcached

#install
RUN mkdir /etc/manila && cp -R etc/manila/* /etc/manila
COPY manila.conf /etc/manila/manila.conf
RUN python setup.py install

#copy config script
COPY config.sh entrypoint.sh /home/manila/
RUN chmod a+x /home/manila/config.sh /home/manila/entrypoint.sh

WORKDIR /home/manila/
#start config
CMD ["/home/manila/config.sh"]
#start service manila-api
WORKDIR /home/manila/
ENTRYPOINT ["/home/manila/entrypoint.sh"]
