#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman -S ninja meson uthash
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y ninja meson uthash
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y ninja meson uthash-dev
else
  echo "OS=$OS not setup yet."
fi

cd "$HOME/projects" || exit
git clone https://github.com/jonaburg/picom
cd picom || exit
meson --buildtype=release . build
ninja -C build
# To install the binaries in /usr/local/bin (optional)
sudo ninja -C build install

exit 0
