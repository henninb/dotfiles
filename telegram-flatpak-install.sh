#!/bin/sh

sudo  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub org.telegram.desktop
echo flatpak install --user flathub org.telegram.desktop
echo flatpak run org.telegram.desktop

exit 0
