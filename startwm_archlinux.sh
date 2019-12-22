#!/usr/bin/env zsh

export TERM="rxvt-256color"
export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"
#xset +fp ~/.fonts
xrdb -merge ~/.Xresources

# for troubleshooting uncomment
#exec xterm
#exec urxvt

. ~/.xinitrc

exit 1
