#!/bin/sh

if [ "$OS" = "Linux Mint" ]; then
  id -g wheel &>/dev/null || sudo groupadd wheel
  #sudo usermod -a -G wheel brian
  sudo useradd -m -G wheel -s /bin/bash brian
  # add group to existing list of secondary groups
  sudo usermod  -a -G tomcat henninb
  sudo usermod  -a -G firefox henninb
  sudo usermod  -a -G intellij henninb
  sudo usermod  -a -G arduino henninb
#sudo adduser -m -G wheel -s /bin/bash henninb
elif [ "$OS" = "Fedora" ]; then
  sudo groupadd wheel
  id -u brian &>/dev/null || sudo useradd -m -G wheel -s /bin/bash brian
  sudo usermod  -a -G tomcat henninb
  sudo usermod  -a -G firefox henninb
  sudo usermod  -a -G intellij henninb
  sudo usermod  -a -G arduino henninb
else
   echo $OS is not yet implemented.
fi

exit 0
