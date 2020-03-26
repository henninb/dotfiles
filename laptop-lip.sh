#!/bin/sh

echo sudo vi /etc/systemd/logind.conf
echo HandleLidSwitch=ignore
sudo systemctl restart systemd-logind

exit 0
