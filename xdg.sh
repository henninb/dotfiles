#!/bin/sh

export XDG_DATA_HOME=$HOME/.local/share/
exit 0

#echo "startkde" > ~/.xsession
#$ D=/usr/share/plasma:/usr/local/share:/usr/share:/var/lib/snapd/desktop
#$ C=/etc/xdg/xdg-plasma:/etc/xdg
#$ C=${C}:/usr/share/kubuntu-default-settings/kf5-settings
export XDG_SESSION_DESKTOP=KDE
export XDG_DATA_DIRS=${D}
export XDG_CONFIG_DIRS=${C}

If the $XDG_DATA_HOME environment variable is not set, search in the ~/.local/share/desktop-directories default directory
