#!/bin/sh

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub org.keepassxc.KeePassXC
echo flatpak run org.keepassxc.KeePassXC

exit 0
