#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  id -g wheel >/dev/null 2>&1 || sudo groupadd wheel
  #sudo usermod -a -G wheel brian
  sudo useradd -m -G wheel -s /bin/zsh brian
  sudo useradd flatpak
  # add group to existing list of secondary groups
  sudo usermod -a -G tomcat "$(id -un)"
  sudo usermod -a -G firefox "$(id -un)"
  sudo usermod -a -G intellij "$(id -un)"
  sudo usermod -a -G arduino "$(id -un)"
  sudo usermod -a -G wheel "$(id -un)"
  sudo usermod -a -G uucp "$(id -un)"
#sudo adduser -m -G wheel -s /bin/bash "$(id -un)"
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  id -g wheel >/dev/null 2>&1 || sudo groupadd wheel
  sudo useradd -m -G wheel -s /bin/zsh brian
  id brian
  sudo usermod -a -G uucp "$(id -un)"
  sudo usermod -a -G tty "$(id -un)"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo usermod -G wheel "$(id -un)"
elif [ "$OS" = "Fedora" ]; then
  sudo groupadd wheel
  id -u brian >/dev/null 2>&1 || sudo useradd -m -G wheel -s /bin/bash brian
  sudo usermod -a -G tomcat "$(id -un)"
  sudo usermod -a -G firefox "$(id -un)"
  sudo usermod -a -G intellij "$(id -un)"
  sudo usermod -a -G arduino "$(id -un)"
elif [ "$OS" = "Gentoo" ]; then
  sudo useradd -m -G wheel -s /bin/zsh brian
  sudo usermod -a -G audio "$(id -un)"
else
   echo "$OS is not yet implemented."
fi

exit 0
