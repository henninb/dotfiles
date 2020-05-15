#!/bin/sh

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if ! flatpak install -y flathub us.zoom.Zoom; then
  flatpak install flathub us.zoom.Zoom
fi
echo flatpak run us.zoom.Zoom

exit 0
