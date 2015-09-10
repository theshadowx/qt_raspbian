FROM  monsendag/rpi-raspbian-qemu:latest
MAINTAINER Ali Diouri <alidiouri@gmail.com>

# PREPARE IMAGE
ADD qemu-arm-static/qemu-arm-static /usr/bin/qemu-arm-static
ADD wrapper/wrapper-i386 /bin/sh
ADD ld_wrapper/ld_wrapper.so /bin/ld_wrapper.so
ADD binproxy /binproxy
ENV PATH /binproxy


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
