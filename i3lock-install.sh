#!/bin/sh

cd ~/projects
git clone https://github.com/i3/i3lock.git
# gh repo clone i3/i3lock
cd i3lock
rm -rf build/
mkdir -p build && cd build/

meson .. -Dprefix=/usr
ninja

echo xss-lock
echo slock

exit 0

# vim: set ft=sh
