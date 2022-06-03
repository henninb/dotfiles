#!/bin/sh

cat > kdenlive-flatpak <<EOF
#!/bin/sh

flatpak run com.discordapp.Discord

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak -y --user install flathub org.kde.kdenlive

chmod 755 kdenlive-flatpak
mv kdenlive-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:
