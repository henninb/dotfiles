#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  wget https://dl.grafana.com/oss/release/grafana_5.4.2_amd64.deb
  sudo apt install -y adduser libfontconfig
  sudo dpkg -i grafana_5.4.2_amd64.deb
  sudo systemctl start grafana-server
  sudo systemctl status grafana-server
  sudo systemctl enable grafana-server

  echo "admin:admin"

  netstat -na | grep LISTEN | grep tcp | grep 3000
  #netstat -tulp
  sudo fuser 3000/tcp
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -S grafana
  sudo systemctl status grafana
  sudo systemctl enable grafana
  sudo systemctl restart grafana

  echo "admin:admin"
  netstat -na | grep LISTEN | grep tcp | grep 3000
  #netstat -tulp
  sudo fuser 3000/tcp

  echo sudo vi /etc/grafana.ini
  echo http server 0.0.0.0
elif [ "$OS" = "Fedora" ]; then
  echo
  sudo dnf install -y grafana
  sudo systemctl status grafana-server
  sudo systemctl enable grafana-server
  sudo systemctl restart grafana-server
  echo "admin:admin"
  netstat -na | grep LISTEN | grep tcp | grep 3000
  #netstat -tulp
  sudo fuser 3000/tcp
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0
