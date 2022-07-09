#!/bin/sh

if [ -x "$(command -v pacman)" ]; then
  yay -S mongodb-bin
  # yay -S mongodb-tools
  yay -S mongodb-tools-bin
  # wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
  sudo systemctl enable mongodb
  sudo systemctl start mongodb
elif [ -x "$(command -v emerge)" ]; then
  sudo emerge --update --newuse app-admin/mongo-tools
  sudo emerge --update --newuse dev-db/mongodb
  echo docker
elif [ -x "$(command -v apt)" ]; then
  echo
elif [ -x "$(command -v xbps-install)" ]; then
  echo
elif [ -x "$(command -v eopkg)" ]; then
  echo
elif [ -x "$(command -v dnf)" ]; then
  echo
elif [ -x "$(command -v brew)" ]; then
  echo
else
  echo "$OS is not yet implemented."
  exit 1
fi


echo mongo

exit 0

# vim: set ft=sh
