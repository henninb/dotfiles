#!/bin/sh

sudo xbps-reconfigure -f glibc-locales
sudo xbps-reconfigure -f glibc-locales
locale -a

exit 0
