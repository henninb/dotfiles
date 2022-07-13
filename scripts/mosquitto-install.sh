#!/bin/sh

# mqtt server
sudo pacman -noconfirm --needed -S mosquitto
sudo apt install -y mosquitto mosquitto-clients
sudo systemctl enable mosquitto
sudo systemctl start mosquitto

echo mosquitto_sub -h localhost -t test
echo mosquitto_pub -h localhost -t test -m "hello world"

exit 0

# vim: set ft=sh
