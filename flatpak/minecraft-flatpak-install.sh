#!/bin/sh

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.mojang.Minecraft
echo flatpak run com.mojang.Minecraft

exit 0
