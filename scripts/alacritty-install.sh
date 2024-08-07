#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo archlinux
elif [ "$OS" = "Gentoo" ]; then
  echo gentoo
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install libfreetype-dev cmake libfontconfig-dev
  doas apt install -y libxcb-shape0-dev
  doas apt install -y libxcb-xfixes0-dev
  doas apt install -y libxkbcommon-dev
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y mesa-dri
elif [ "$OS" = "FreeBSD" ]; then
  echo freebsd
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo opensuse
elif [ "$OS" = "Solus" ]; then
  echo solus
elif [ "$OS" = "Clear Linux OS" ]; then
  doas swupd bundle-add devpkg-freetype
  doas swupd bundle-add devpkg-libxml2
  doas swupd bundle-add devpkg-expat
  doas swupd bundle-add performance-tools
  doas swupd bundle-add devpkg-libxcb
elif [ "$OS" = "Fedora Linux" ]; then
  echo fedora
elif [ "$OS" = "Darwin" ]; then
  echo macos
else
  echo "$OS is not yet implemented."
  exit 1
fi

mkdir -p "$HOME/projects/github.com/alacritty"
cd "$HOME/projects/github.com/alacritty" || exit
git clone git@github.com:alacritty/alacritty.git
cd ./alacritty || exit
git pull origin master
cargo build --release
sudo mv -v target/release/alacritty /usr/local/bin

exit 0

# vim: set ft=sh:
