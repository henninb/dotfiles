#!/bin/sh

doas systemctl enable getty@tty{2,3,4,5,6}.service
sudo sed -i 's/^#NAutoVTs=/NAutoVTs=/' /etc/systemd/logind.conf
echo /etc/systemd/logind.conf | grep NAutoVTs
doas usermod -a -G tty henninb
echo sudo chvt 1
xmodmap -pke | grep XF86Switch_VT
# echo /etc/systemd/logind.conf
# echo NAutoVTs=6
exit 0

# vim: set ft=sh:
