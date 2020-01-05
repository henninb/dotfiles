#!/usr/bin/env sh

export TERM="xterm-256color"
#export LANG=en_US.UTF-8
#export LC_CTYPE="en_US.UTF-8"

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


#xset +fp ~/.fonts
xrdb -merge ~/.Xresources

# for troubleshooting uncomment
#exec xterm
#exec urxvt

. ~/.xinitrc

exit 0
