#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse dev-java/gradle-bin
  sudo emerge --update --newuse dev-java/openjdk-bin
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y openjdk-8-jdk
elif [ "$OS" = "Ubuntu" ]; then
  sudo apt install -y openjdk-8-jdk
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install java-1.8.0-openjdk-devel
elif [ "$OS" = "Linux Mint" ]; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y openjdk-8-jdk
else
  echo $OS is not yet implemented.
  exit 1
fi

exit 0
