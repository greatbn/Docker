FROM saphi/ubuntu-python:2.7.11
MAINTAINER Sa Phi <saphi070@gmail.com>
#install dependencies

RUN  apt-get install -y python-dev libssl-dev python-pip \
	libmysqlclient-dev libxml2-dev libxslt-dev libpq-dev git \
	git-review libffi-dev gettext graphviz libjpeg-dev

#upgrade pip

RUN pip install --upgrade pip
RUN pip install pytz tox python-memcached pymysql

WORKDIR /home/

#clone project from github
RUN git clone https://github.com/openstack/manila.git -b stable/mitaka
WORKDIR /home/manila

#install requirements
RUN pip install -r requirements.txt

#install

RUN mkdir /etc/manila && cp -R etc/manila/* /etc/manila
RUN python setup.py install

#generate config file

RUN tox -egenconfig
RUN cp etc/manila/manila.conf.sample /etc/manila/manila.conf

#install config tool
RUN apt-get install -y crudini

#copy config script
COPY config.sh entrypoint.sh /home/manila/
RUN chmod a+x /home/manila/config.sh /home/manila/entrypoint.sh

WORKDIR /home/manila/

CMD ["./config.sh"]

ENTRYPOINT ["./entrypoint.sh"]
