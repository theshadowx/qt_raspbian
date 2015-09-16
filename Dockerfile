FROM resin/rpi-raspbian:wheezy-2015-09-09
MAINTAINER Ali Diouri <alidiouri@gmail.com>

#RUN rm /etc/apt/sources.list
#RUN touch /etc/apt/sources.list
RUN echo "deb http://archive.raspbian.org/raspbian wheezy main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.raspbian.org/raspbian wheezy main contrib non-free" >> /etc/apt/sources.list 

# install depdencies
RUN apt-get update && \
    apt-get upgrade -y && \
     apt-get install -y libfontconfig1-dev libdbus-1-dev libfreetype6-dev  \ 
libudev-dev libicu-dev libsqlite3-dev libxslt1-dev libssl-dev libasound2-dev \ 
libavcodec-dev libavformat-dev libswscale-dev libgstreamer0.10-dev \ 
libgstreamer-plugins-base0.10-dev gstreamer-tools gstreamer0.10-plugins-good \
gstreamer0.10-plugins-bad libraspberrypi-dev libpulse-dev libx11-dev \
libglib2.0-dev libcups2-dev freetds-dev libsqlite0-dev libpq-dev libiodbc2-dev \
libmysqlclient-dev firebird-dev libpng12-dev libjpeg62-dev libgst-dev \
libxext-dev libxcb1 libxcb1-dev libx11-xcb1 libx11-xcb-dev libxcb-keysyms1 \
libxcb-keysyms1-dev libxcb-image0 libxcb-image0-dev libxcb-shm0 libxcb-shm0-dev \
libxcb-icccm4 libxcb-icccm4-dev libxcb-sync0 libxcb-sync0-dev libxcb-render-util0 \
libxcb-render-util0-dev libxcb-xfixes0-dev libxrender-dev libxcb-shape0-dev \
libxcb-randr0-dev libxcb-glx0-dev libxi-dev libdrm-dev glew-utils libglew-dev \
libmtdev-dev unixodbc libgles2-mesa-dev evtest tslib libts-bin wget

WORKDIR /opt
RUN git clone git://code.qt.io/qt/qt5.git
WORKDIR qt5
RUN git checkout 5.5
RUN /opt/qt5/init-repository
RUN /opt/qt5/configure -v -opengl es2 -opensource -confirm-license -optimized-qmake -reduce-exports -release -nomake examples -qt-pcre -make libs -prefix /usr/local/qt5
RUN make -j4
RUN make install
RUN rm -r /opt/qt5

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer
WORKDIR /home/developer
