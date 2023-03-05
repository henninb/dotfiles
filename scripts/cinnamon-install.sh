#!/bin/sh

if ! command -v cinnamon-session; then
  sudo emerge --update --newuse cinnamon
fi

dconf load /org/cinnamon/desktop/keybindings/ < "$HOME/documents/cinnamon-keybindings"

dconf write /org/cinnamon/desktop/background/picture-uri "'file:///usr/share/backgrounds/linuxmint-qiana/j_baer_5976503592.jpg'"

gsettings set org.cinnamon.desktop.default-applications.terminal exec /home/henninb/.local/share/cargo/bin/alacritty
gsettings set org.cinnamon.desktop.default-applications.terminal exec-arg "-x"

gsettings get org.cinnamon.desktop.background picture-uri
gsettings get org.cinnamon.desktop.background picture-opacity
gsettings get org.cinnamon.desktop.background picture-options

gsettings set org.cinnamon.desktop.background picture-uri \'${new}\'
exit 0
