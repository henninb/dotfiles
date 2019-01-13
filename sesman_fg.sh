#!/bin/sh

sudo kill -9 $(pgrep -f xrdp-sesman)
sudo xrdp-sesman -n
pgrep -f xrdp-sesman

exit 0
