#!/bin/bash
# install apache
dnf install -y httpd
# generate index.html
ZONE=$(curl -s http://169.254.169.254/latest/meta-data/zoneCode)
echo "[$(hostname)]-[Init-V1.0] on [Zone ${ZONE}]" > /var/www/html/index.html
# register service httpd & start
systemctl enable --now httpd
