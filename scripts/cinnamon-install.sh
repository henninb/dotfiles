#!/bin/sh

if ! command -v cinnaomon-session; then
  sudo emerge --update --newuse cinnamon
fi

dconf load /org/cinnamon/desktop/keybindings/ < "$HOME/documents/cinnamon-keybindings"

gsettings set org.cinnamon.desktop.default-applications.terminal exec /home/henninb/.local/share/cargo/bin/alacritty
gsettings set org.cinnamon.desktop.default-applications.terminal exec-arg "-x"

exit 0
