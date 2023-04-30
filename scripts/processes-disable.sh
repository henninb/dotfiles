#!/bin/sh

doas systemctl disable jenkins
doas systemctl disable influxdb
doas systemctl disable kafka
doas systemctl disable grafana-server
doas systemctl disable activemq
doas systemctl disable zookeeper

exit 0

# vim: set ft=sh:
