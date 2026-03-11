#!/bin/bash

FTP_USER=${FTP_USER:-ftpuser}
FTP_PASSWORD=$(cat /run/secrets/ftp_pass)

# create required vsftpd directory
mkdir -p /var/run/vsftpd/empty

useradd -m "$FTP_USER"
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

usermod -d /var/www/html "$FTP_USER"

exec vsftpd /etc/vsftpd.conf