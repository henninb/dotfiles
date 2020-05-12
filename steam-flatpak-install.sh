#!/bin/sh

sudo  flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.valvesoftware.Steam
echo flatpak install --user flathub com.valvesoftware.Steam
echo flatpak install -y --user flathub com.valvesoftware.Steam
echo flatpak run com.valvesoftware.Steam

exit 0
