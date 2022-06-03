#!/bin/sh

cat > handbrake-flatpak <<EOF
#!/bin/sh

flatpak run fr.handbrake.ghb

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub fr.handbrake.ghb

chmod 755 handbrake-flatpak
mv handbrake-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:
