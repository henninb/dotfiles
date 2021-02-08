#!/bin/sh

sudo ip link set dev enp0s31f6 up
sudo dhclient enp0s31f6

exit 0
sudo ip addr add dev enp0s31f6 192.168.100.218/24

#sudo ifconfig enp0s31f6 192.168.100.208 netmask 255.255.255.0
ip a show
sudo route add default gw 192.168.100.254 enp0s31f6
echo sudo vi /etc/resolv.conf

