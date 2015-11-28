FROM ubuntu:latest
MAINTAINER zaolin <zaolin@das-labor.org>

ENV DEBIAN_FRONTEND=noninteractive

# Prerequisites
RUN apt-get update && \
	apt-get install -y wget dnsutils prosody software-properties-common && \
	rm /etc/prosody/conf.*/localhost.cfg.lua

RUN add-apt-repository 'deb http://download.jitsi.org/nightly/deb unstable/' && \
	apt-get update && \
	apt-get -y install jitsi-meet jigasi && \
	apt-get clean

RUN add-apt-repository 'deb http://http.debian.net/debian jessie-backports main' && \
	apt-get update && \
	apt-get install -y openjdk-8-jdk && \
	update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

EXPOSE 80 443
