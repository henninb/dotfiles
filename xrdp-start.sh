#!/bin/sh

# future
#export DISPLAY=localhost:0
#export $(dbus-launch)
#exec dbus-launch --exit-with-x11 /etc/xrdp/startwm.sh
#sudo dbus-launch --exit-with-x11 /etc/xrdp/startwm.sh

sudo kill -9 $(pgrep -f xrdp)
sudo xrdp

sudo kill -9 $(pgrep -f xrdp-sesman)
sudo xrdp-sesman -n
pgrep -f xrdp-sesman

exit 0
