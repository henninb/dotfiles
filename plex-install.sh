#!/bin/sh

curl -s https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
sudo apt -y update
sudo apt -y install plexmediaserver
sudo systemctl status plexmediaserver
sudo mkdir -p /opt/plexmedia/{movies,series,music}
sudo chown -R plex: /opt/plexmedia

echo http://YOUR_SERVER_IP:32400/web
echo http://192.168.10.10:32400/web

sudo usermod -a -G plex "$(id -un)"

exit 0
