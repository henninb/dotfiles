#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "sudo pacman --noconfirm --needed -S"
elif [ "$OS" = "Gentoo" ]; then
  echo "sudo emerge --update --newuse"
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev
elif [ "$OS" = "Void" ]; then
  echo "sudo xbps-install -y"
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

gdbus call --session --dest org.freedesktop.DBus --object-path /org/freedesktop/Dbus --method org.freedesktop.DBus.ListNames

mkdir -p "$HOME/projects/github.com/dunst-project"
cd "$HOME/projects/github.com/dunst-project" || exit
git clone --recursive git@github.com:dunst-project/dunst.git
cd dunst || exit
make
doas make install
cd - || exit

exit 0

# vim: set ft=sh:
