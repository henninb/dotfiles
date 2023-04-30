#!/bin/sh
doas ip link set enp3s0 up
doas dhclient
exit 0

# vim: set ft=sh:
