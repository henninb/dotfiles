#!/bin/sh

flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub org.stellarium.Stellarium
echo flatpak run org.stellarium.Stellarium

exit 0
