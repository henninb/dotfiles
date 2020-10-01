#!/bin/sh

cat > keepass-flatpak <<EOF
#!/bin/sh

flatpak run org.keepassxc.KeePassXC

exit 0
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub org.keepassxc.KeePassXC

chmod 755 keepass-flatpak
mv keepass-flatpak "$HOME/.local/bin/"

exit 0
