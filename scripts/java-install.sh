#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse dev-java/openjdk-bin:17
  eselect java-vm set user openjdk-bin-17
  sudo eselect java-vm set system openjdk-bin-17
  #echo sudo java-config --set-system-vm openjdk-bin-17
  echo emerge -v openjdk:11
  echo /var/db/repos/gentoo/dev-java/openjdk
  echo eselect java-vm list
elif [ "$OS" = "Darwin" ]; then
  brew install openjdk
  brew install openjdk@17
  brew install --cask adoptopenjdk
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install -y openjdk-17
  # openjdk-8-devel
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y openjdk-8-jdk
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S jdk19-openjdk
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y portmaster
  sudo portmaster -o java/openjdk17
  sudo pkg install -y openjdk17
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y java-11-openjdk
  # sudo zypper install -y java-1_8_0-openjdk
  # sudo zypper install -y java-1_8_0-openjdk-devel
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y openjdk17
  # echo openjdk11-bin
elif [ "$OS" = "Ubuntu" ] || [ "$OS" = "Debian GNU/Linux" ]; then
  sudo apt install -y openjdk-17-jdk
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y java-17-openjdk-devel
elif [ "$OS" = "Linux Mint" ]; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y openjdk-17-jdk
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh
