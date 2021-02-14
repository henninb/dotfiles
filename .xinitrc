#!/bin/sh

export PATH=${HOME}/.local/bin:${PATH}
export PATH=/usr/local/sbin:/usr/sbin:${PATH}

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE=C
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_PAPER=en_US.UTF-8
export LC_NAME=en_US.UTF-8
export LC_ADDRESS=en_US.UTF-8
export LC_TELEPHONE=en_US.UTF-8
export LC_MEASUREMENT=en_US.UTF-8
export LC_IDENTIFICATION=en_US.UTF-8

# needed for spacefm theme
# export GTK2_RC_FILES=/usr/share/themes/Ant-Dracula/gtk-2.0/gtkrc

export _JAVA_AWT_WM_NONREPARENTING=1

if [ -x "$(command -v xrdb)" ]; then
  #xrdb -merge ~/.Xresources
  xrdb -load "$HOME/.Xresources" >> "$HOME/xinit.log"
else
  echo "xrdb not installed."
fi

#for f in /etc/X11/Xsession.d/*; do
#  echo $f >> "$HOME/xinit.log"
#  [ -x "$f" ] && . "$f"
#done
#unset f

##TODO: is this required?
#for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
#    [ -x "$f" ] && . "$f"
#done
#unset f

# Addd for gentoo - could not resolve keysym xf86 fullscreen
setxkbmap -option compose:ralt
# added on 10/28/2020 for making caps lock key work like the control key
setxkbmap -option ctrl:nocaps       # Make Caps Lock a Control key
setxkbmap -option ctrl:swapcaps     # Swap Left Control and Caps Lock
#xmodmap ~/.xmodmap

# list of different WMs
#exec mate-session
#exec i3
#exec awesome
#exec qtile
#exec xmonad
#exec bspwm

xrandr --listproviders >> "$HOME/xinit.log"

# WM=$(head -1 < "$HOME/.active-wm")
# if [ -s "$HOME/.active-wm" ] && [ -x "$(command -v "${WM}")" ]; then
#   echo "Found window manager = ${WM}." >> "$HOME/xinit.log"
#   export DESKTOP_SESSION=${WM}
# else
#   echo i3 > "$HOME/.active-wm"
#   WM=i3
#   echo "Set to default window manager = ${WM}." >> "$HOME/xinit.log"
# fi

# if [ "${WM}" = "bspwm" ]; then
#   exec bspwm 2>> "$HOME/xinit.log"
# elif [ "${WM}" = "xmonad" ]; then
#   export "$(dbus-launch)"
#   exec dbus-launch xmonad 2>> "$HOME/xinit.log"
# elif [ -x "$(command -v ${WM})" ]; then
#   exec ${WM} 2>> "$HOME/xinit.log"
# else
#   echo "failed to find window manager ${WM}." >> "$HOME/xinit.log"
#   exit 1
# fi

exec xmonad-start 2>> "$HOME/xinit.log"
