#!/bin/sh

sudo mkdir -p /opt/influxdb-data
sudo chmod 777 /opt/influxdb-data
docker-compose up -d

exit 0
