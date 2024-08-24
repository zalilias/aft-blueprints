#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
yum -y update

# Install packages:
yum makecache
yum -y install bind-utils
yum -y install htop
yum -y install traceroute
yum -y install wget
yum -y install telnet

# Configure SSH client alive interval for ssh session timeout:
echo 'ClientAliveInterval 60' | sudo tee --append /etc/ssh/sshd_config;
service sshd restart;

# Set dark background for vim:
touch /home/ec2-user/.vimrc;
echo "set background=dark" >> /home/ec2-user/.vimrc;