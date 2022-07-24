#!/bin/sh

cat > peazip-flatpak <<EOF
#!/bin/sh

flatpak run io.github.peazip.PeaZip

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub io.github.peazip.PeaZip

chmod 755 peazip-flatpak
mv -v peazip-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:
