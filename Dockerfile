#
# rdiff-backup-openssh-server 
#
FROM debian:latest
MAINTAINER Patrick Flaig

RUN apt-get update
RUN apt-get --no-install-recommends install -y openssh-server rdiff-backup
RUN rm -rf /var/lib/apt/lists/*

EXPOSE 22/tcp
