#!/bin/sh

sudo mv -v /etc/localtime /etc/localtime.bak
sudo ln -s /usr/share/zoneinfo/US/Central /etc/localtime

exit 0

# vim: set ft=sh:
