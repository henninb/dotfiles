#!/bin/sh

sudo freebsd-update -r 13.0 upgrade
sudo freebsd-update fetch
sudo freebsd-update install

exit 0

# vim: set ft=sh:

