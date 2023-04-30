#!/bin/sh

mkdir -p "$HOME/projects/phuhl"
cd "$HOME/projects/phuhl" || exit
git clone git@github.com:phuhl/linux_notification_center.git deadd
cd deadd || exit
make
doas make install

exit 0

# vim: set ft=sh:
