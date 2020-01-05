#!/bin/sh

# future
#export DISPLAY=localhost:0
#export $(dbus-launch)
#exec dbus-launch --exit-with-x11 /etc/xrdp/startwm.sh
#sudo dbus-launch --exit-with-x11 /etc/xrdp/startwm.sh

#ps -ef| grep '^xrdp$' | grep -v grep

#pgrep -x xrdp
sudo rm -rfv rm /run/xrdp.pid
sudo rm -rfv /var/log/xrdp.log
sudo pkill -x xrdp
sudo nohup xrdp > /dev/null 2>&1

pgrep -x xrdp

sudo pkill -x xrdp-sesman
#sudo kill -9 $(pgrep -f xrdp-sesman)
sudo nohup xrdp-sesman -n > /dev/null 2>&1 &
pgrep -x xrdp-sesman

exit 0
