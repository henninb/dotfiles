#!/bin/sh

cd "$HOME/projects" || exit
git clone https://github.com/jonaburg/picom
cd picom || exit
meson --buildtype=release . build
ninja -C build
# To install the binaries in /usr/local/bin (optional)
sudo ninja -C build install

exit 0
