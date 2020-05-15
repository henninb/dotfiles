#!/bin/sh

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub io.github.liberodark.OpenDrive
echo flatpak run io.github.liberodark.OpenDrive

exit 0
