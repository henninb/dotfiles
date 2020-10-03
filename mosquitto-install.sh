#!/bin/sh

# mqtt server
sudo pacman -S mosquitto
sudo systemctl enable mosquitto
sudo systemctl start mosquitto

exit 0
