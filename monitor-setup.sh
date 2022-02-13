#!/bin/sh

echo 'Modeline "2560x1440_30.00"  146.25  2560 2680 2944 3328  1440 1443 1448 1468 -hsync +vsync'
cvt 3840 2160 30

# gtf 2560 1440 30
xrandr --newmode "3840x2160_30"  338.75  3840 4080 4488 5136  2160 2163 2168 2200 -hsync +vsync

xrandr --addmode HDMI-0 '3840x2160_30'

exit 0
