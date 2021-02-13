#!/bin/sh

sudo systemctl status grafana-server
netstat -na | grep LISTEN | grep tcp | grep 3000
#netstat -tulp
sudo fuser 3000/tcp

exit 0
