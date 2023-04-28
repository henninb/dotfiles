#!/bin/sh

echo Xorg
pgrep -x Xorg
sudo rm -rfv /run/xrdp.pid
sudo rm -rfv /var/log/xrdp.log
sudo pkill -x xrdp
sudo nohup xrdp > /dev/null 2>&1
pgrep -x xrdp

sudo rm -rfv /run/xrdp-sesman.pid
sudo rm -rfv /var/log/xrdp-sesman.log
sudo pkill -x xrdp-sesman
sudo nohup xrdp-sesman > /dev/null 2>&1 &
pgrep -x xrdp-sesman

exit 0

# vim: set ft=sh:
