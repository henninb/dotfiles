#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "archlinux"
elif [ "$OS" = "Gentoo" ]; then
  echo "gentoo"
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  curl -s https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
  echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
  sudo apt -y update
  sudo apt -y install plexmediaserver
elif [ "$OS" = "Void" ]; then
  echo "void"
elif [ "$OS" = "FreeBSD" ]; then
  echo "freebsd"
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo opensuse
elif [ "$OS" = "Fedora Linux" ]; then
  echo "fedora"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
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

# vim: set ft=sh:
