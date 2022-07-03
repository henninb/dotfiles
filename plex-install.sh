#!/bin/sh

if [ -x "$(command -v pacman)" ]; then
  echo
elif [ -x "$(command -v emerge)" ]; then
  echo
elif [ -x "$(command -v apt)" ]; then
  curl -s https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
  echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
  sudo apt -y update
  sudo apt -y install plexmediaserver
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

if [ ! -x "$(command -v systemctl)" ]; then
  echo systemctl not installed.
  exit 1
fi
sudo systemctl status plexmediaserver
sudo mkdir -p /opt/plexmedia/music
sudo mkdir -p /opt/plexmedia/series
sudo mkdir -p /opt/plexmedia/movies
sudo chown -R plex: /opt/plexmedia

echo http://YOUR_SERVER_IP:32400/web
echo http://192.168.10.10:32400/web

sudo usermod -a -G plex "$(id -un)"

exit 0
