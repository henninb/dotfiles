#!/bin/sh

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.valvesoftware.Steam
echo flatpak install --user flathub com.valvesoftware.Steam
echo flatpak install -y --user flathub com.valvesoftware.Steam
echo flatpak run com.valvesoftware.Steam
echo flatpak list

exit 0
