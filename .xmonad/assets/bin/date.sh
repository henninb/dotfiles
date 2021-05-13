#!/bin/sh

# FG='#ffffff'
# BG='#003aff'
# FONT='-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*'
date_icon="^i($HOME/.xmonad/assets/icons/date.xbm)"
cnormal="^fg(#dddddd)"
cyellow="^fg(#a88c29)"

while true ; do
  dt=" ${cyellow}${date_icon} ${cnormal}$(date "+%m-%d-%Y %I:%M:%S")"
  # dt=`date +"%a %b %d %l:%M %p "`
  printf "%s\n" "$dt"
  sleep 1
done
#| dzen2 -e '' -x '800' -h '14' -w '880' -ta r -fg $FG -bg $BG -fn $FONT

exit 0

4 # vim: set ft=sh:
