#!/bin/sh

echo sudo vi /etc/systemd/logind.conf
echo HandleLidSwitch=ignore
sudo systemctl restart systemd-logind
# setterm -term linux -blank 10 -powerdown 5 </dev/tty1 >/dev/tty1

exit 0

# vim: set ft=sh:

