#!/bin/bash
sudo amazon-linux-extras install -y nginx1.12
sudo yum install -y git
sudo git clone https://github.com/zhangke0516/mmp.git /root/mmp
sudo cat /root/mmp/nginx/nginx-stream.conf >> /etc/nginx/nginx.conf
sudo cp -r /root/mmp/nginx/tcp.d /etc/nginx/
sudo systemctl start nginx

echo "include /etc/nginx/conf.d/*.conf;" >> /etc/nginx/nginx.conf
