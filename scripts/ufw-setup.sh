#!/bin/sh

sudo emerge

sudo systemctl enable ufw --now
# sudo systemctl start ufw
sudo ufw enable
sudo ufw status
sudo ufw app list
sudo ufw limit SSH
sudo ufw status
sudo ufw allow dns

exit 0
