#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  yay -S mongodb-bin
  # yay -S mongodb-tools
  yay -S mongodb-tools-bin
  # wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
  sudo systemctl enable mongodb
  sudo systemctl start mongodb
elif [ "$OS" = "Gentoo" ]; then
  # sudo emerge --update --newuse app-admin/mongo-tools
  # sudo emerge --update --newuse dev-db/mongodb
  sudo emerge -update --newuse '=dev-db/mongodb-4.4.10::gentoo'
  # sudo emerge --update --newuse app-admin/mongosh-bin
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo "debian"
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

echo 'nix-env -i mongodb'

exit 0

# vim: set ft=sh:
