#!/usr/bin/env sh

if [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  sudo apt remove lightdm gdm
  sudo apt install -y awesome plank docky vicious
elif [ "$OS" = "Arch Linux" ]; then
  sudo pacman --noconfirm --needed -S awesome vicious plank
elif [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman -Rsnc lightdm
  sudo pacman --noconfirm --needed -S awesome
elif [ "$OS" = "Gentoo" ]; then
  GENTOO_PKGS="awesome feh"
  FAILURES=""
  for i in $(echo $GENTOO_PKGS); do
    sudo emerge --update --newuse $i
    if [ 0 -ne $? ]; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo Failures: $FAILURE
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y awesome
else
  echo $OS is not yet implemented.
  exit 1
fi

echo $HOME/.xinitrc
cat $HOME/.xinitrc

echo exec awesome

exit 0
