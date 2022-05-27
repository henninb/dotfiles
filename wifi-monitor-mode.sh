#!/bin/sh

sudo ip link set wlp0s20u7 down
sudo iw dev wlp0s20u7 set type monitor
sudo ip link set wlp0s20u7 up

exit 0
