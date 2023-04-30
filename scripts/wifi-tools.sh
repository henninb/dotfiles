#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  # sudo pacman --noconfirm --needed -S networkmanager
  doas pacman --noconfirm --needed -S dialog
  doas pacman --noconfirm --nedded -S aircrack-ng
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse networkmanager
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y network-manager
  doas apt install -y wicd-curses
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y NetworkManager
  doas xbps-install -y dkms
elif [ "$OS" = "FreeBSD" ]; then
  echo "sudo pkg install -y"
elif [ "$OS" = "OpenBSD" ]; then
  echo "OpenBSD"
elif [ "$OS" = "Solus" ]; then
  "sudo eopkg install -y"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo "sudo zypper install -y"
elif [ "$OS" = "Fedora Linux" ]; then
  echo "sudo dnf install -y"
elif [ "$OS" = "Clear Linux OS" ]; then
  "sudo swupd bundle-add"
elif [ "$OS" = "Darwin" ]; then
  echo "brew install"
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

# sudo ln -sfn /etc/sv/dbus /var/service/dbus
# sudo ln -sfn /etc/sv/NetworkManager /var/service/NetworkManager

if [ -x "$(command -v nmcli)" ]; then
  nmcli device
  echo nmcli device show
  echo nmcli r wifi on
  nmcli device wifi list
  doas nmcli -a d wifi connect NSA_classified
  doas nmcli networking off
  doas nmcli connection delete id NSA_classified
fi

ip addr show
lsusb | grep '802.11ac'

# sudo nmcli connection delete NSA_classified

# echo works on archlinux
# sudo wifi-menu wlp7s0
# echo wicd-curses

exit 0

# vim: set ft=sh:
