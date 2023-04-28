#!/bin/sh

xrandr --prop
Xephyr -br -ac -noreset -screen 1024x768 :1 &
#Xephyr -br -ac -noreset -screen 1280x1024 :1 &
echo export DISPLAY=:1

exit 0

xrandr --prop
lshw -c display
#Not giving standard mode: 1152x864, 75Hz
#Not giving standard mode: 1280x1024, 60Hz
#Not giving standard mode: 1280x960, 60Hz
#Not giving standard mode: 1440x900, 60Hz
#Not giving standard mode: 1600x1200, 60Hz
#Not giving standard mode: 1680x1050, 60Hz
#Not giving standard mode: 1920x1080, 60Hz

# vim: set ft=sh:
