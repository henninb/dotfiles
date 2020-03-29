#!/bin/sh

sudo freebsd-update -r 12.1 upgrade
sudo freebsd-update fetch
sudo freebsd-update install

exit 0
