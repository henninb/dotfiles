#!/bin/sh

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub io.github.celluloid_player.Celluloid
echo flatpak install --user flathub io.github.celluloid_player.Celluloid
echo flatpak run io.github.celluloid_player.Celluloid

exit 0
