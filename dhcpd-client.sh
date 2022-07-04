#!/bin/sh

sudo dhclient -r -v enp3s0 && sudo rm /var/lib/dhcp/dhclient.* ; sudo dhclient -v enp3s0

exit 0

# vim: set ft=sh:
