#!/usr/bin/env bash

SLEEP=1

#cblue="^fg(#92bbd0)"
cgray="^fg(#999999)"
cwhite="^fg(#ffffff)"
cnormal="^fg(#dddddd)"
cred="^fg(#bc4547)"
cyellow="^fg(#a88c29)"
cgreen="^fg(#00aa6c)"
#cpurple="^fg(#9542f4)"

fs_icon="^i($HOME/.xmonad/assets/icons/diskette.xbm)"
cpu_icon="^i($HOME/.xmonad/assets/icons/cpu.xbm)"
mem_icon="^i($HOME/.xmonad/assets/icons/mem.xbm)"
date_icon="^i($HOME/.xmonad/assets/icons/date.xbm)"

sunny_icon="^i($HOME/.xmonad/assets/icons/sunny.xbm)"
rainny_icon="^i($HOME/.xmonad/assets/icons/rainny.xbm)"
snowy_icon="^i($HOME/.xmonad/assets/icons/snowy.xbm)"
# stormydaniels="^i($HOME/.xmonad/assets/icons/stormydaniels.xbm)"
cloudy_icon="^i($HOME/.xmonad/assets/icons/cloudy.xbm)"
#partially="^i($HOME/.xmonad/assets/icons/partially.xbm)"
foggy_icon="^i($HOME/.xmonad/assets/icons/fog.xbm)"


weather="${cyellow}${cloudy_icon} ${cnormal}$(~/.xmonad/assets/bin/weather.sh) F${cgray}"

while :; do

memory="${cyellow}${mem_icon} ${cnormal}$(~/.xmonad/assets/bin/memory.sh)${cgray}"
hdd="${cyellow}${fs_icon} ${cnormal}$(~/.xmonad/assets/bin/hdd.sh)${cgray}"

echo -e "$memory | $hdd | $weather"

sleep $SLEEP; done

exit 0
