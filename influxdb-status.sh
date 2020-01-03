#!/bin/sh

sudo systemctl status influxdb
netstat -na | grep LISTEN | grep tcp | grep 8086
sudo fuser 8086/tcp
curl -i -XPOST http://localhost:8086/query -u henninb:monday1 --data-urlencode "q=CREATE DATABASE metrics"

exit 0
