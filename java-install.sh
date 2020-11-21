#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  # sudo emerge --update --newuse dev-java/gradle-bin
  sudo emerge --update --newuse dev-java/openjdk-bin
  sudo java-config --set-system-vm openjdk-bin-8
  echo emerge -v openjdk:11
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install -y openjdk-8
  # openjdk-8-devel
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y openjdk-8-jdk
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -S jdk8-openjdk
  # echo sudo pacman --noconfirm --needed -S jdk-openjdk
elif [ "$OS" = "FreeBSD" ]; then
  sudo portmaster -o java/openjdk8 linux-oracle-jdk18
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  # sudo zypper install -y java-11-openjdk
  # sudo zypper install -y java-1_8_0-openjdk
  sudo zypper install -y java-1_8_0-openjdk-devel
elif [ "$OS" = "void" ]; then
  sudo xbps-install -S openjdk
elif [ "$OS" = "Ubuntu" ]; then
  sudo apt install -y openjdk-8-jdk
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install java-1.8.0-openjdk-devel
elif [ "$OS" = "Linux Mint" ]; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y openjdk-8-jdk
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0
