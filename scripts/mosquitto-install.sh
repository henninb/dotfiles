#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman -noconfirm --needed -S mosquitto
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse mosquitto
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y mosquitto mosquitto-clients
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

doas systemctl enable mosquitto
doas systemctl start mosquitto
doas systemctl status mosquitto

echo port 1883
echo mosquitto_sub -h localhost -t test
echo mosquitto_pub -h localhost -t test -m "hello world"

exit 0

# vim: set ft=sh:
