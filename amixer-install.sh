#!/bin/sh

sudo xbps-install -S ConsoleKit2 pulseaudio alsa-utils

sudo ln -s /etc/sv/alsa /var/service/
sudo ln -s /etc/sv/dbus /var/service/
sudo ln -s /etc/sv/cgmanager /var/service/
sudo ln -s /etc/sv/consolekit /var/service/
sudo usermod -a -G pulse-access henninb

# in .xinitrc
# start-pulseaudio-x11 &

# manually start
pulseaudio --start

exit 0
