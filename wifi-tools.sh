#!/bin/sh

sudo apt install  network-manager
echo sudo emerge networkmanager

sudo pacman -S networkmanager
sudo systemctl start NetworkManager

nmcli d
nmcli device show
echo nmcli r wifi on
nmcli d wifi list
echo nmcli d wifi connect [ssid] password [password]

exit 0
