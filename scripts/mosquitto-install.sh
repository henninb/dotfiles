#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman -noconfirm --needed -S mosquitto
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse mosquitto
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y mosquitto mosquitto-clients
elif [ "$OS" = "Void" ]; then
  echo "void"
elif [ "$OS" = "FreeBSD" ]; then
  echo "freebsd"
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo opensuse
elif [ "$OS" = "Fedora Linux" ]; then
  echo "fedora"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
else
  echo "$OS is not yet implemented."
  exit 1
fi

sudo systemctl enable mosquitto
sudo systemctl start mosquitto
sudo systemctl status mosquitto

echo port 1883
echo mosquitto_sub -h localhost -t test
echo mosquitto_pub -h localhost -t test -m "hello world"

exit 0

# vim: set ft=sh:
