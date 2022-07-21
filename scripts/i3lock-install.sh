#!/bin/sh

mkdir -p "$HOME/projects/github.com/i3"
cd "$HOME/projects/github.com/i3" || exit
git clone https://github.com/i3/i3lock.git
# gh repo clone i3/i3lock
cd i3lock
rm -rf build/
mkdir -p build
cd build || exit
meson .. -Dprefix=/usr
ninja

echo xss-lock
echo slock

exit 0

# vim: set ft=sh:
