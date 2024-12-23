#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse dev-java/openjdk-bin:17
  eselect java-vm set user openjdk-bin-17
  doas eselect java-vm set system openjdk-bin-17
  #echo sudo java-config --set-system-vm openjdk-bin-17
  echo emerge -v openjdk:11
  echo /var/db/repos/gentoo/dev-java/openjdk
  echo eselect java-vm list

  eselect java-vm list
  doas emerge --update --newuse  dev-java/openjdk-bin:21
  doas eselect java-vm set system 2
  eselect java-vm set user 2
  java -version
elif [ "$OS" = "Darwin" ]; then
  brew install openjdk
  brew install openjdk@17
  brew install --cask adoptopenjdk
elif [ "$OS" = "Solus" ]; then
  doas eopkg install -y openjdk-17
  # openjdk-8-devel
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y openjdk-8-jdk
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S jdk21-openjdk
  doas pacman --noconfirm --needed -S jdk23-openjdk
elif [ "$OS" = "FreeBSD" ]; then
  doas pkg install -y portmaster
  sudo portmaster -o java/openjdk17
  doas pkg install -y openjdk17
elif [ "$OS" = "Alpine Linux" ]; then
  test
  doas apk add openjdk17
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y java-17-openjdk-devel
  #doas zypper install -y java-19-openjdk-devel
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y openjdk17
  # echo openjdk11-bin
elif [ "$OS" = "Ubuntu" ] || [ "$OS" = "Debian GNU/Linux" ]; then
  doas apt install -y openjdk-17-jdk
elif [ "$OS" = "Fedora Linux" ]; then
  #sudo dnf install -y java-17-openjdk-devel
  doas dnf install -y java-19-openjdk-devel
elif [ "$OS" = "Linux Mint" ]; then
  doas apt update
  doas apt upgrade -y
  doas apt install -y openjdk-17-jdk
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
