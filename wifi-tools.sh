#!/bin/sh

sudo apt install -y network-manager
sudo apt install -y wicd-curses
sudo emerge --update --newuse networkmanager
sudo pacman --noconfirm --needed -S networkmanager
sudo pacman --noconfirm --needed -S dialog
sudo xbps-install NetworkManager
sudo xbps-install dkms

sudo systemctl start NetworkManager
sudo rc-service NetworkManager start

sudo ln -s /etc/sv/NetworkManager /var/service
sudo ln -s /etc/sv/dbus /var/service

nmcli -version
nmcli device
echo nmcli device show
echo nmcli r wifi on
nmcli device wifi list
sudo nmcli -a d wifi connect NSA_classified
ip addr show
sudo nmcli networking off

sudo nmcli connection delete id NSA_classified
# sudo nmcli connection delete NSA_classified

echo works on archlinux
sudo wifi-menu wlp7s0
echo wicd-curses

exit 0
