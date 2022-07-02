#!/bin/bash

sudo -s 
apt-get install nginx -y
RESULT=`hostname`
echo ${RESULT} > /var/www/html/index.html
systemctl restart nginx 