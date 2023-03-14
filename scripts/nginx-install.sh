#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S nginx
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse nginx
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y nginx
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y nginx
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y nginx
  sudo sysrc nginx_enable="YES"
  sudo service nginx start
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y nginx
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y nginx
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
