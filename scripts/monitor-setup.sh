#!/bin/sh

cat << EOF > "$HOME/tmp/50-monitor.conf"
Section "Monitor"
  Identifier "HDMI-0"
  Option  "Primary" "True"
EndSection

Section "Monitor"
    Identifier "HDMI-1"
    Option  "RightOf" "HDMI-0"
    Option  "Rotate" "left"
EndSection
EOF

cat << EOF > "$HOME/tmp/10-monitor.conf"
Section "Monitor"
  Identifier "Monitor0"
  Modeline "3840x2160_60.00"  712.34  3840 4152 4576 5312  2160 2161 2164 2235  -HSync +Vsync
EndSection
Section "Screen"
  Identifier "Screen0"
  Device "HDMI-0"
  Monitor "Monitor0"
  DefaultDepth 24
  SubSection "Display"
    Depth 24
    Modes "3840x2160_60.00"
  EndSubSection
EndSection
EOF

sudo mv -v "$HOME/tmp/10-monitor.conf" /etc/X11/xorg.conf.d/10-monitor.conf

# echo 'Modeline "2560x1440_30.00"  146.25  2560 2680 2944 3328  1440 1443 1448 1468 -hsync +vsync'
#echo cvt 3840 2160 30
echo cvt 3840 2160 60
# cvt 3360 1890 30
#
gtf 3840 2160 60

# gtf 2560 1440 30
# xrandr --newmode "3840x2160_30"  338.75  3840 4080 4488 5136  2160 2163 2168 2200 -hsync +vsync
# xrandr --newmode "3840x2160_30"  338.75  3840 4080 4488 5136  2160 2163 2168 2200 -hsync +vsync
echo xrandr --newmode "3840x2160_60"  712.75  3840 4160 4576 5312  2160 2163 2168 2237 -hsync +vsync
# xrandr --newmode "3360x1890_30"  257.75  3360 3560 3912 4464  1890 1893 1898 1925 -hsync +vsync

echo xrandr --addmode HDMI-0 '3840x2160_60'
# xrandr --addmode HDMI-0 '3360x1890_30'

echo xrandr --output HDMI-1 --auto --right-of HDMI-0 --rotate left
echo xrandr --output HDMI-1 --auto --right-of HDMI-0
echo xrandr --output HDMI-1 --rotate left
echo xrandr --output HDMI-1 --rotate right
echo xrandr --output HDMI-1 --rotate normal
echo xrandr --output HDMI-1 --rotate inverted

echo turn on second monitor
echo xrandr --output HDMI-1 --auto --right-of HDMI-0
echo turn off second monitor
echo xrandr --output HDMI-1 --off

exit 0

# vim: set ft=sh
