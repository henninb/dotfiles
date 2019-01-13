#!/usr/bin/env sh

if [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  sudo apt remove lightdm gdm
  sudo apt install -y i3status i3blocks i3 xterm i3lock rofi terminator feh ranger dolphin zsh suckless-tools qt5ct nitrogen
elif [ "$OS" = "Arch Linux" ]; then
  sudo pacman --noconfirm --needed -S i3status i3blocks i3-wm xterm i3lock rofi termite terminator dmenu feh ranger dolphin zsh qt5ct terminus-font
elif [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman -Rsnc lightdm
  sudo pacman --noconfirm --needed -S i3status i3blocks i3-wm xterm i3lock rofi termite terminator dmenu feh ranger dolphin zsh qt5ct terminus-font
elif [ "$OS" = "Gentoo" ]; then
  GENTOO_PKGS="x11-misc/i3status i3blocks i3 xterm i3lock rofi terminator dmenu dolphin ranger feh"
  FAILURES=""
  for i in $(echo $GENTOO_PKGS); do
    sudo emerge --update --newuse $i
    if [ 0 -ne $? ]; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo Failures: $FAILURE
elif [ "$OS" = "Fedora" ]; then
  echo
  sudo dnf install -y i3status
  sudo dnf install -y i3
  sudo dnf install -y i3lock
  sudo dnf install -y xterm
  sudo dnf install -y i3lock
  sudo dnf install -y terminator
  sudo dnf install -y dmenu
  #sudo dnf install -y dolphin
  sudo dnf install -y neofetch
  sudo dnf install -y terminus-fonts-console
  sudo dnf install -y terminus-fonts
  sudo dnf install -y feh
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y i3status i3 i3lock xterm i3lock terminator dmenu dolphin terminus-fonts-console terminus-fonts
else
  echo $OS is not yet implemented.
  exit 1
fi

#echo $HOME/.xinitrc
#echo exec i3

exit 0
