#!/bin/sh

cat > libreoffice-flatpak <<EOF
#!/bin/sh

flatpak run --filesystem=home org.libreoffice.LibreOffice

exit 0
# vim: set ft=sh
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if ! flatpak --user -y install flathub org.libreoffice.LibreOffice; then
  flatpak -y install flathub org.libreoffice.LibreOffice
fi

chmod 755 libreoffice-flatpak
mv -v libreoffice-flatpak "$HOME/.local/bin/"

# sudo flatpak override us.zoom.Zoom --filesystem=host
# sudo flatpak run --filesystem=home us.zoom.Zoom

exit 0
# vim: set ft=sh:
