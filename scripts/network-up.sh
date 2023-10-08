#!/bin/sh

if [ $# -ne 2 ]; then
    ip address show
    echo "Usage: $0 <device> <y/n static>"
    exit 1
fi

DEVICE=$1
IS_STATIC=$2

if [ "$IS_STATIC" = "y" ]; then
  sudo ip addr add dev "${DEVICE}" 192.168.10.40/24
  doas ip route add default via 192.168.10.1
  echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
  doas ip link set dev "${DEVICE}" up
  # echo sudo ip link set dev virbr0 up
  ping -c 4 192.168.10.1
else
  echo sudo ip link set dev "${DEVICE}" up
  doas ip link set dev "${DEVICE}" up
  echo sudo dhclient "${DEVICE}"
  doas dhclient "${DEVICE}"
  ping -c 4 192.168.10.1
fi

#echo sudo systemctl enable --now dhclient@enp0s5.service

exit 0

# vim: set ft=sh:
