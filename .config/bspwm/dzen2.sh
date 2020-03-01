#!/bin/sh

~/.config/bspwm/bspwmbar | dzen2 -e - -w '960' -ta r -x 960&
~/.config/bspwm/bspwmws | dzen2 -e - -w '960' -ta l &
