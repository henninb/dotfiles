#!/bin/sh

docker stop splunk-server
docker rm splunk-server -f
docker run -d -p 8000:8000 -e "SPLUNK_START_ARGS=--accept-license" -e "SPLUNK_PASSWORD=monday12" --restart=always --name splunk-server splunk/splunk:latest

exit 0
