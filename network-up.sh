#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <device>"
    exit 1
fi

DEVICE=$1

sudo ip link set dev "${DEVICE}" up
sudo dhclient "${DEVICE}"
ping -c 4 192.168.100.254

echo examples
echo sudo ip addr add dev "${DEVICE}" 192.168.100.218/24
echo sudo route add default gw 192.168.100.254 "${DEVICE}"
echo sudo vi /etc/resolv.conf
echo sudo ip link set dev enp3s0 up
echo sudo ip link set dev virbr0 up

exit 0
