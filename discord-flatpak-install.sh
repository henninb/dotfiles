#!/bin/sh

sudo flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.discordapp.Discord
#flatpak install -y --user flathub com.discordapp.Discord
echo flatpak run com.discordapp.Discord

exit 0
