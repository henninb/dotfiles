#!/bin/sh

cat > celluloid-flatpak <<EOF
#!/bin/sh

flatpak run io.github.celluloid_player.Celluloid

exit 0
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub io.github.celluloid_player.Celluloid
chmod 755 celluloid-flatpak
mv -v celluloid-flatpak "$HOME/.local/bin/celluloid-flatpak"

exit 0
