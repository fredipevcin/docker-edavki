FROM ubuntu:14.04
MAINTAINER Fredi Pevcin <fredi.pevcin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN \
    echo debconf shared/accepted-oracle-license-v1-1 select true | \
        sudo debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | \
        sudo debconf-set-selections

RUN \
    apt-get update && apt-get install -y \
        oracle-java8-installer \
        x11vnc xvfb \
        firefox libnss3-tools \
        lxde

RUN \
    mkdir -p ~/.vnc && \
    touch ~/.vnc/passwd && \
    x11vnc -storepasswd "1234" ~/.vnc/passwd

RUN sh -c 'echo "startlxde &\nfirefox https://edavki.durs.si" >> ~/.bashrc'

CMD ["/usr/bin/x11vnc", "-forever", "-usepw", "-create"]
