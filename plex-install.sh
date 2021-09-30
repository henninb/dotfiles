#!/bin/sh

curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
sudo apt -y update
sudo apt -y install plexmediaserver
sudo systemctl status plexmediaserver
sudo mkdir -p /opt/plexmedia/{movies,series,music}
sudo chown -R plex: /opt/plexmedia

echo http://YOUR_SERVER_IP:32400/web
echo http://192.168.100.54:32400/web

exit 0
