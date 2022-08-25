#!/bin/sh

docker run -d -p 8000:8000 -e "SPLUNK_START_ARGS=--accept-license" -e "SPLUNK_PASSWORD=monday1" --name splunk-server splunk/splunk:latest

exit 0
