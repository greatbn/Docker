FROM ubuntu
MAINTAINER Sa Phi <saphi070@gmail.com>
RUN apt-get –y install apache2
EXPOSE 80
ENTRYPOINT  ["/usr/sbin/apache2ctl","-D","FOREGROUND"]