#!/bin/sh

cat > zoom-flatpak <<EOF
#!/bin/sh

flatpak run us.zoom.Zoom

exit 0
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if ! flatpak --user -y install flathub us.zoom.Zoom; then
  flatpak -y install flathub us.zoom.Zoom
fi

chmod 755 zoom-flatpak
mv zoom-flatpak "$HOME/.local/bin/"

exit 0
