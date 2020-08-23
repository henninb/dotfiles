#!/bin/sh

pkg-config --exists gtk+-3.0 && echo "gtk+ 3.0 is installed" || echo "gtk+ 3.0 is not installed"
pkg-config --exists gtk+-2.0 && echo "gtk+ 2.0 is installed" || echo "gtk+ 2.0 is not installed"

# echo sudo apt install -y gtk2.0
# echo sudo apt install -y gtk+3.0
echo sudo apt install -y libgtk2.0-dev
echo sudo apt install -y libgtk-3-dev
echo sudo eopkg install -y libgtk-2-devel

echo sudo emerge --update --newuse x11-libs/gtk+:2
echo sudo emerge --update --newuse x11-libs/gtk+:3

exit 0
