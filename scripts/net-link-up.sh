#!/bin/sh
sudo ip link set enp3s0 up
sudo dhclient
exit 0

# vim: set ft=sh:
