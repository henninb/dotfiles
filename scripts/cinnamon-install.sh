#!/bin/sh

# if ! command -v cinnamon-session; then
# fi

if [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y cinnamon
elif [ "$OS" = "Void" ]; then
  echo "void"
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "arch"
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y cinnamon
elif [ "$OS" = "Solus" ]; then
  echo solus
elif [ "$OS" = "Debian GNU/Linux" ]; then
  sudo apt install -y cinnamon
elif [ "$OS" = "Ubuntu" ]; then
  sudo apt install -y cinnamon
elif [ "$OS" = "Linux Mint" ]; then
  sudo apt install -y cinnamon
elif [ "$OS" = "FreeBSD" ]; then
  echo freebsd
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse cinnamon
else
  echo "$OS is not yet implemented."
  exit 0
fi

dconf load /org/cinnamon/desktop/keybindings/ < "$HOME/documents/cinnamon-keybindings"

# dconf write /org/cinnamon/desktop/background/picture-uri "'file:///usr/share/backgrounds/linuxmint-qiana/j_baer_5976503592.jpg'"
dconf write /org/cinnamon/desktop/background/picture-uri "'file:///home/henninb/.local/wallpaper/mountain-road.jpg'"

gsettings set org.cinnamon.desktop.default-applications.terminal exec /home/henninb/.local/share/cargo/bin/alacritty
gsettings set org.cinnamon.desktop.default-applications.terminal exec-arg "-x"

gsettings get org.cinnamon.desktop.background picture-uri
gsettings get org.cinnamon.desktop.background picture-opacity
gsettings get org.cinnamon.desktop.background picture-options

#gsettings set org.cinnamon.desktop.background picture-uri \'${new}\'

xdg-settings set default-web-browser brave-bin.desktop

exit 0
# vim: set ft=sh:
