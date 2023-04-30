#!/bin/sh

doas systemctl stop NetworkManager

doas ip link set wlp0s20u7 down
doas airmon-ng check kill

doas airmon-ng start wlp0s20u7

echo sudo airmon-ng start wlp0s20u7 1
echo sudo airodump-ng -c 1 wlp0s20u7mon
# sudo iw dev wlp0s20u7 set type monitor
doas ip link set wlp0s20u7 up

echo sudo airodump-ng wlp0s20u7
echo wlan.bssid eq B0:7F:B9:89:0A:82
# monitor channel 6
echo sudo airodump-ng wlp0s20u7 -c 6

# besside-ng -R 'Target Network' wlan0mon

exit 0

# vim: set ft=sh:
