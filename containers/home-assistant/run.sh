#!/bin/sh

mkdir -p ~/homeassistant/config

docker run -d \
  --name home-assistant \
  --restart unless-stopped \
  -e TZ=America/Chicago \
  -v ~/homeassistant/config:/config \
  -p 8123:8123 \
  homeassistant/home-assistant:stable

exit 0
  --network 192.168.10.10 \
