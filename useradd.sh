#!/bin/sh

if [ "$OS" = "Linux Mint" ]; then
  sudo groupadd wheel
  #sudo usermod -a -G wheel brian
  sudo useradd -m -G wheel -s /bin/bash brian

  # add group to existing list of secondary groups
  sudo usermod  -a -G tomcat henninb
#sudo adduser -m -G wheel -s /bin/bash henninb
fi

exit 0
