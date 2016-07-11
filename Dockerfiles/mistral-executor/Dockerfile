FROM python:2.7.11-alpine
MAINTAINER Sa Phi <saphi070@gmail.com>
# Install package dependencies
RUN apk add --update python py-pip  python-dev build-base git gcc musl-dev libxml2-dev \
  libxslt-dev libffi-dev openssl-dev linux-headers\
  && rm -rf /var/cache/apk/*

#clone source code
WORKDIR /home
RUN git clone https://github.com/openstack/mistral.git -b stable/mitaka


#install python library
WORKDIR /home/mistral
RUN pip install -r requirements.txt
RUN pip install pymysql python-memcached

#install
RUN mkdir /etc/mistral && cp -R etc/* /etc/mistral
COPY mistral.conf /etc/mistral/
RUN python setup.py install
WORKDIR /home/mistral
RUN cp -r mistral/resources /usr/lib/python2.7/dist-packages/mistral && \
  cp mistral/actions/openstack/mapping.json /usr/lib/python2.7/site-packages/mistral/actions/openstack

#copy config script
COPY config.sh entrypoint.sh /home/mistral/
RUN chmod a+x /home/mistral/config.sh /home/mistral/entrypoint.sh

WORKDIR /home/mistral/
#start config
CMD ["./config.sh"]
#start service mistralmistral-api
WORKDIR /home/mistral/
ENTRYPOINT ["./entrypoint.sh"]
