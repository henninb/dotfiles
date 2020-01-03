#!/bin/sh

sudo systemctl status influxdb
netstat -na | grep LISTEN | grep tcp | grep 8086
sudo fuser 8086/tcp

exit 0
