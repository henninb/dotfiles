#!/bin/sh

sudo systemctl enable getty@tty{2,3,4,5,6}.service
sudo sed -i 's/^#NAutoVTs=/NAutoVTs=/' /etc/systemd/logind.conf
echo /etc/systemd/logind.conf | grep NAutoVTs
sudo usermod -a -G tty henninb
echo chvt <TTY number>
# echo /etc/systemd/logind.conf
# echo NAutoVTs=6
exit 0

# vim: set ft=sh
