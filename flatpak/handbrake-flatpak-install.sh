#!/bin/sh

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub fr.handbrake.ghb
echo flatpak run fr.handbrake.ghb

exit 0
