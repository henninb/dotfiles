#!/bin/sh

cat /proc/asound/cards

sudo xbps-install -S ConsoleKit2 pulseaudio alsa-utils
sudo pacman -S alsa-utils

sudo ln -s /etc/sv/alsa /var/service/
sudo ln -s /etc/sv/dbus /var/service/
sudo ln -s /etc/sv/cgmanager /var/service/
sudo ln -s /etc/sv/consolekit /var/service/

sudo usermod -a -G pulse-access henninb
sudo usermod -a -G audio henninb

# in .xinitrc
# start-pulseaudio-x11 &

# manually start
sudo pacman -S pulseaudio
pulseaudio --start

exit 0
