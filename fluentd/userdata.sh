#!/bin/bash
sudo yum install -y git
sudo git clone https://github.com/zhangke0516/mmp.git /root/mmp
sudo curl -L https://toolbelt.treasuredata.com/sh/install-amazon2-td-agent3.sh | sh
sudo cp /root/mmp/fluentd/td-agent-syslog/td-agent-syslog.conf /etc/td-agent/
sudo cp /root/mmp/fluentd/td-agent-syslog/td-agent-syslog.service /usr/lib/systemd/system/
sudo systemctl daemon-reload
sudo /opt/td-agent/embedded/bin/fluent-gem install alertmanager fluent-plugin-route
sudo systemctl start td-agent-syslog
