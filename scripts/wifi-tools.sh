#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  # sudo pacman --noconfirm --needed -S networkmanager
  sudo pacman --noconfirm --needed -S dialog
  sudo pacman --noconfirm --nedded -S aircrack-ng
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y network-manager
  sudo apt install -y wicd-curses
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse networkmanager
elif [ "$OS" = "Void" ]; then
  sudo xbps-install NetworkManager
  sudo xbps-install dkms
else
  echo "$OS is not yet implemented."
  exit 1
fi

if [ -x "$(command -v systemctl)" ]; then
  echo sudo systemctl start NetworkManager
fi

if [ -x "$(command -v rc-service)" ]; then
  echo sudo rc-service NetworkManager start
fi

# sudo ln -sfn /etc/sv/NetworkManager /var/service
# sudo ln -sfn /etc/sv/dbus /var/service

if [ -x "$(command -v nmcli)" ]; then
  nmcli device
  echo nmcli device show
  echo nmcli r wifi on
  nmcli device wifi list
  sudo nmcli -a d wifi connect NSA_classified
  sudo nmcli networking off
  sudo nmcli connection delete id NSA_classified
fi

ip addr show
lsusb | grep '802.11ac'

# sudo nmcli connection delete NSA_classified

# echo works on archlinux
# sudo wifi-menu wlp7s0
# echo wicd-curses

exit 0

# vim: set ft=sh
