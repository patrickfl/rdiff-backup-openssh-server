#
# rdiff-backup-openssh-server 
#
FROM debian:buster-slim
MAINTAINER Patrick Flaig

# Disable interactive installer interface
ENV DEBIAN_FRONTEND noninteractive

# Install openssh-server
RUN apt-get update && \
apt-get --no-install-recommends install -y openssh-server rdiff-backup && \
rm -rf /var/lib/apt/lists/* && \
mkdir /var/run/sshd

# Create user and home
RUN useradd --create-home --shell /bin/bash rdiff-backup

# sshd hardening, disable root login, enable pubkey authentication, disable password authentication
RUN sed -i 's/#LoginGraceTime 2m/LoginGraceTime 2m/' /etc/ssh/sshd_config && \
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
sed -i 's/#StrictModes yes/StrictModes yes/' /etc/ssh/sshd_config && \
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
sed -i 's/X11Forwarding yes/X11Forwarding no/' /etc/ssh/sshd_config && \
sed -i 's/Subsystem/#Subsystem/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Expose port 22 for SSH
EXPOSE 22/tcp

# Start SSHD
CMD ["/usr/sbin/sshd", "-D"]
