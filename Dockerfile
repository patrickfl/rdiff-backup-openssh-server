#
# rdiff-backup-openssh-server 
#
FROM debian:latest
MAINTAINER Patrick Flaig

# Install openssh-server
RUN apt-get update && \
apt-get --no-install-recommends install -y openssh-server rdiff-backup && \
rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd

# Create user and home
RUN useradd --create-home --shell /bin/bash rdiff-backup
RUN echo 'rdiff-backup:rdiff-backup' | chpasswd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Copy perconfigured files
COPY root/ /

EXPOSE 22/tcp
CMD ["/usr/sbin/sshd", "-D"]
