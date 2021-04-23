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

export _JAVA_AWT_WM_NONREPARENTING=1

if [ -x "$(command -v xrdb)" ]; then
  xrdb -load "$HOME/.Xresources" >> "$HOME/xinit.log"
else
  echo "xrdb not installed."
fi

setxkbmap -option "caps:escape"

xrandr --listproviders >> "$HOME/xinit.log"

exec xmonad-start 2>> "$HOME/xinit.log"
