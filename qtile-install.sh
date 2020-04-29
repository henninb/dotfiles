#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt remove gdm
  sudo apt remove lightdm
  sudo apt install -y qtile
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman -Rsnc gdb
  sudo pacman -Rsnc lightdm
  sudo pacman --noconfirm --needed -S qtile
elif [ "$OS" = "Gentoo" ]; then
  GENTOO_PKGS="qtile"
  FAILURES=""
  for i in $(echo $GENTOO_PKGS); do
    sudo emerge --update --newuse $i
    if [ 0 -ne $? ]; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo Failures: $FAILURE
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y qtile
else
  echo $OS is not yet implemented.
  exit 1
fi

exit 0
