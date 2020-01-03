#!/bin/sh

if [ "$OS" = "Arch Linux" ]; then
  locale | sudo tee /etc/locale.conf
  echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
  echo "en_US ISO-8859-1" | sudo tee -a /etc/locale.gen
  sudo locale-gen
fi

exit 0
