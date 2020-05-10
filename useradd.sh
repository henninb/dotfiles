#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  id -g wheel >/dev/null 2>&1 || sudo groupadd wheel
  #sudo usermod -a -G wheel brian
  sudo useradd -m -G wheel -s /bin/zsh brian
  sudo useradd flatpak
  # add group to existing list of secondary groups
  sudo usermod -a -G tomcat henninb
  sudo usermod -a -G firefox henninb
  sudo usermod -a -G intellij henninb
  sudo usermod -a -G arduino henninb
  sudo usermod -a -G wheel henninb
  sudo usermod -a -G uucp henninb
#sudo adduser -m -G wheel -s /bin/bash henninb
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  id -g wheel >/dev/null 2>&1 || sudo groupadd wheel
  sudo useradd -m -G wheel -s /bin/zsh brian
  id brian
  sudo usermod -a -G uucp henninb
  sudo usermod -a -G tty henninb
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo usermod -G wheel henninb
elif [ "$OS" = "Fedora" ]; then
  sudo groupadd wheel
  id -u brian >/dev/null 2>&1 || sudo useradd -m -G wheel -s /bin/bash brian
  sudo usermod -a -G tomcat henninb
  sudo usermod -a -G firefox henninb
  sudo usermod -a -G intellij henninb
  sudo usermod -a -G arduino henninb
elif [ "$OS" = "Gentoo" ]; then
  sudo useradd -m -G wheel -s /bin/zsh brian
  sudo usermod -a -G audio henninb
else
   echo "$OS is not yet implemented."
fi

exit 0
