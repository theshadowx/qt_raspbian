FROM  resin/rpi-raspbian:wheezy-2015-09-09
MAINTAINER Ali Diouri <alidiouri@gmail.com>

ENV INITSYSTEM on

# install depdencies
RUN apt-get update
RUN apt-get -y upgrade && \
    apt-get install -y       \
    git                     \
    make                    \
    build-essential         \
    g++                     \
    lib32gcc1               \
    nano                    \
    libc6-i386              \
    python                  \
    python2.7               \
    unzip                   \
    wget libicu48 net-tools

WORKDIR /home
RUN wget https://s3-ap-southeast-2.amazonaws.com/purinda.com/raspberrypi/qt-everywhere-opensource-src-5.3.2_compiled_armv7l.tar.gz
RUN tar xf qt-everywhere-opensource-src-5.3.2_compiled_armv7l.tar.gz -C qt-everywhere-opensource-src-5.3.2
RUN cd qt-everywhere-opensource-src-5.3.2 && make install
WORKDIR /home
RUN rm qt-everywhere-opensource-src-5.3.2_compiled_armv7l.tar.gz
RUN rm -r qt-everywhere-opensource-src-5.3.2
