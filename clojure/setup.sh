#!/bin/sh

wget -O ~/bin/lein https://raw.github.com/technomancy/leiningen/stable/bin/lein

if [ "$OS" = "Arch Linux" ]; then
  sudo pacman --noconfirm --needed -S jre8-openjdk
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y openjdk8
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) ]; then
  sudo apt install -y openjdk-8-jdk
elif [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo
elif [ "$OS" = "Alpine Linux" ]; then
  sudo apk update
  sudo apk fetch openjdk8
  sudo apk add openjdk8
elif [ "$OS" = "Gentoo" ]; then
  wget 'https://download.oracle.com/otn/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.tar.gz?AuthParam=1563536898_481a13f998f994ba089678321fac80d2' -O jdk-8u202-linux-x64.tar.gz
  sudo eselect news read
  sudo emerge -u dev-java/openjdk-bin
  echo sudo emerge -u dev-java/oracle-jdk-bin
  echo sudo mv jdk-8u202-linux-x64.tar.gz /usr/portage/distfiles
else
  echo $OS is not implemented.
  exit 1
fi
lein

exit 0
