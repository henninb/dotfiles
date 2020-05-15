#!/bin/sh

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub io.dbeaver.DBeaverCommunity
#flatpak install -y --user flathub com.discordapp.Discord
echo flatpak run io.dbeaver.DBeaverCommunity

exit 0
