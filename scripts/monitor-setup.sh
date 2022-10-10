#!/bin/sh

cat << EOF > "$HOME/tmp/50-monitor.conf"
Section "Monitor"
    Identifier "eDP1"
EndSection

Section "Monitor"
    Identifier  "DP1-1"
    Option      "RightOf" "eDP1"
    Option      "PreferredMode" "1920x1080"
    Option      "Primary" "True"
EndSection

Section "Monitor"
    Identifier  "HDMI-1"
    Option      "RightOf" "HDMI-0"
    Option      "Rotate"  "left"
    Option      "PreferredMode" "2560x1440"
EndSection

Section "Monitor"
    Identifier  "HDMI1"
    Option      "RightOf" "eDP1"
    Option      "PreferredMode" "1920x1080"
    Option  "Primary" "True"
EndSection
EOF

sudo mv -v "$HOME/tmp/50-monitor.conf" /etc/X11/xorg.conf.d/50-monitor.conf

# echo 'Modeline "2560x1440_30.00"  146.25  2560 2680 2944 3328  1440 1443 1448 1468 -hsync +vsync'
#echo cvt 3840 2160 30
echo cvt 3840 2160 60
# cvt 3360 1890 30

# gtf 2560 1440 30
# xrandr --newmode "3840x2160_30"  338.75  3840 4080 4488 5136  2160 2163 2168 2200 -hsync +vsync
# xrandr --newmode "3840x2160_30"  338.75  3840 4080 4488 5136  2160 2163 2168 2200 -hsync +vsync
echo xrandr --newmode "3840x2160_60"  712.75  3840 4160 4576 5312  2160 2163 2168 2237 -hsync +vsync
# xrandr --newmode "3360x1890_30"  257.75  3360 3560 3912 4464  1890 1893 1898 1925 -hsync +vsync

echo xrandr --addmode HDMI-0 '3840x2160_60'
# xrandr --addmode HDMI-0 '3360x1890_30'

echo xrandr --output HDMI-1 --auto --right-of HDMI-0 --rotate left
xrandr --output HDMI-1 --rotate left
xrandr --output HDMI-1 --rotate right
xrandr --output HDMI-1 --rotate normal
xrandr --output HDMI-1 --rotate inverted

exit 0

# vim: set ft=sh
