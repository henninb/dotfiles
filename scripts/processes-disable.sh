#!/bin/sh

sudo systemctl disable jenkins
sudo systemctl disable influxdb
sudo systemctl disable kafka
sudo systemctl disable grafana-server
sudo systemctl disable activemq
sudo systemctl disable zookeeper

exit 0

# vim: set ft=sh:
