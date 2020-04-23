#!/bin/sh

sudo apt install -y network-manager
sudo emerge --update --newuse networkmanager
sudo pacman --noconfirm --needed -S networkmanager

sudo systemctl start NetworkManager

nmcli -version
nmcli device
nmcli device show
echo nmcli r wifi on
nmcli device wifi list
sudo nmcli -a d wifi connect NSA_classified

exit 0
