#!/bin/sh

cat > opendrive-flatpak <<EOF
#!/bin/sh

flatpak run io.github.liberodark.OpenDrive

exit 0

# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub io.github.liberodark.OpenDrive

chmod 755 opendrive-flatpak
mv opendrive-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:
