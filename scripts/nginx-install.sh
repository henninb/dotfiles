#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S nginx
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse nginx
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y nginx
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y nginx
elif [ "$OS" = "FreeBSD" ]; then
  doas pkg install -y nginx
  doas sysrc nginx_enable="YES"
  doas service nginx start
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y nginx
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y nginx
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
