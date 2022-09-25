#!/bin/sh

sudo systemctl enable getty@tty{2,3,4,5,6}.service
echo /etc/systemd/logind.conf | grep NAutoVTs
echo /etc/systemd/logind.conf
echo NAutoVTs=6
exit 0
