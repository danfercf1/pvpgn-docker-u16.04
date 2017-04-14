FROM ubuntu:16.04
MAINTAINER danfercf@gmail.com
RUN apt-get update
RUN apt-get install -y build-essential libboost-all-dev libbz2-dev libmysqlclient-dev libgmp3-dev liblua5.1-0-dev cmake git
WORKDIR /usr/src/
RUN git clone https://github.com/danfercf1/pvpgn-server.git pvpgn
WORKDIR /usr/src/pvpgn/ 
RUN cmake -D CMAKE_INSTALL_PREFIX=/ -D WITH_MYSQL=true -D WITH_LUA=true ./ && make && make install
WORKDIR /
#ADD files/. /var/pvpgn/files/
COPY bnetd.conf /etc/pvpgn
COPY channel.conf /etc/pvpgn
EXPOSE 6112 6200
RUN mkdir -p /var/log/pvpgn/ && mkdir -p /var/pvpgn/maps
CMD /sbin/bnetd && tail -f /dev/null
