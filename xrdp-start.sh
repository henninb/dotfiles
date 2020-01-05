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
  sudo rm -v rm /var/run/xrdp/xrdp.pid
  sudo rm -v /run/xrdp.pid
  sleep 1
  sudo xrdp
else
  sudo rm -v rm /run/xrdp.pid
  sudo rm -v /var/log/xrdp.log
  sudo xrdp
fi

exit 1

sudo kill -9 $(pgrep -f xrdp-sesman)
sudo xrdp-sesman -n
pgrep -f xrdp-sesman

exit 0
