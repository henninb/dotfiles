#!/bin/sh

if [ "$OS" = "Arch Linux" ]; then
  echo "fix"
elif [ "$OS" = "CentOS Linux" ]; then
  echo sudo yum install -y kdeconnect
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  sudo apt install -y kdeconnect
else
  echo $OS is not yet implemented.
  exit 1
fi

exit 0
