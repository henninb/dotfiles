#!/bin/sh

Xephyr -br -ac -noreset -screen 800x600 :1 &
export DISPLAY=:1

exit 0
