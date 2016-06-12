FROM ubuntu:14.04
RUN apt-get update && apt-get install -y software-properties-common && \
	apt-add-repository ppa:fkrull/deadsnakes-python2.7 -y && \
	apt-get update && apt-get -y install python2.7 python2.7-dev && \
	apt-get install -y python-pip
RUN apt-get purge -y software-properties-common && \
	apt-get -y autoremove && \
	apt-get clean

