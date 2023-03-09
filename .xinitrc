#!/bin/sh

export PATH=${HOME}/.local/bin:${HOME}/.nix-profile/bin:/sbin:/usr/sbin:/usr/local/sbin:${PATH}

echo >> "$HOME/tmp/xinit.log"
echo $(date) >> "$HOME/tmp/xinit.log"
echo home=$HOME >> "$HOME/tmp/xinit.log"
echo path=$PATH >> "$HOME/tmp/xinit.log"

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

mkdir -p "$HOME/tmp"

if [ -x "$(command -v xhost)" ]; then
  # xhost si:localuser:root
  xhost +
fi

if [ -x "$(command -v xrdb)" ]; then
  xrdb -load "$HOME/.Xresources" >> "$HOME/tmp/xinit.log"
else
  echo "xrdb not installed." >> "$HOME/tmp/xinit.log"
fi

setxkbmap -option "caps:escape"

xrandr --listproviders >> "$HOME/tmp/xinit.log"

exec xmonad-start 2>> "$HOME/tmp/xinit.log"

# vim: set ft=sh:
