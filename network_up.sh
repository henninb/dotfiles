#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <device>"
    exit 1
fi

DEVICE=$1
sudo ip link set dev ${DEVICE} up
echo sudo ip link set dev enp3s0 up
echo sudo ip link set dev virbr0 up

exit 0
