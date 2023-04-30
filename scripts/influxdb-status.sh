#!/bin/sh

INFLUXDB_PASSWORD="********"

doas systemctl status influxdb
netstat -na | grep LISTEN | grep tcp | grep 8086
sudo fuser 8086/tcp
curl -i -XPOST http://localhost:8086/query -u "henninb:${INFLUXDB_PASSWORD}" --data-urlencode "q=CREATE DATABASE metrics"

exit 0

# vim: set ft=sh:
