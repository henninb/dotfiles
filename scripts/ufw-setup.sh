#!/bin/sh

sudo emerge

sudo systemctl enable ufw --now
# sudo systemctl start ufw
sudo ufw enable
sudo ufw status
sudo ufw app list
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw limit SSH
sudo ufw delete 1
sudo ufw status
sudo ufw status numbered
sudo ufw allow dns
sudo ufw allow 80/tcp comment 'accept http connections'
sudo ufw allow 443/tcp comment 'accept https connections'

exit 0
