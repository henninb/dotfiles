#!/bin/sh

# future
#export DISPLAY=localhost:0
#export $(dbus-launch)
#exec dbus-launch --exit-with-x11 /etc/xrdp/startwm.sh
#sudo dbus-launch --exit-with-x11 /etc/xrdp/startwm.sh

ps -ef| grep xrdp | grep -v grep
if [ $? -ne 0 ]; then
  sudo pkill xrdp
  sleep 1
  sudo xrdp
fi

sudo kill -9 $(pgrep -f xrdp-sesman)
sudo xrdp-sesman -n
pgrep -f xrdp-sesman

exit 0
