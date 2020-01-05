#!/bin/sh
#export DISPLAY=localhost:0
export $(dbus-launch)
exec dbus-launch --exit-with-x11 /etc/xrdp/startwm.sh
#sudo dbus-launch --exit-with-x11 /etc/xrdp/startwm.sh
