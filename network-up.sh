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
echo sudo ip route add default via 192.168.100.254
echo "nameserver 192.168.100.254" | sudo tee -a /etc/resolv.conf
echo sudo ip link set dev "${DEVICE}" up
echo sudo ip link set dev virbr0 up

echo sudo systemctl enable --now dhclient@enp0s5.service

exit 0
