#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  # sudo emerge --update --newuse dev-java/gradle-bin
  # sudo emerge --update --newuse dev-java/openjdk-bin
  sudo emerge --update --newuse dev-java/openjdk-bin:11
  sudo emerge --update --newuse dev-java/openjdk-bin:17
  echo sudo java-config --set-system-vm openjdk-bin-8
  echo emerge -v openjdk:11
  echo eselect java-vm list
  echo eselect java-vm set user openjdk-bin-8
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install -y openjdk-11
  # openjdk-8-devel
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y openjdk-8-jdk
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S jdk11-openjdk
  # echo sudo pacman --noconfirm --needed -S jdk-openjdk
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y portmaster
  sudo portmaster -o java/openjdk11 #linux-oracle-jdk18
  sudo pkg install -y openjdk11
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  # sudo zypper install -y java-11-openjdk
  # sudo zypper install -y java-1_8_0-openjdk
  sudo zypper install -y java-1_8_0-openjdk-devel
elif [ "$OS" = "void" ]; then
  sudo xbps-install -y openjdk11
  # echo openjdk11-bin
elif [ "$OS" = "Ubuntu" ] || [ "$OS" = "Debian GNU/Linux" ]; then
  sudo apt install -y openjdk-11-jdk
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y java-11-openjdk-devel
elif [ "$OS" = "Linux Mint" ]; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y openjdk-11-jdk
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh
