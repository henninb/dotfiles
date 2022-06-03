#!/bin/sh

cat > telegram-flatpak <<EOF
#!/bin/sh

flatpak run org.telegram.desktop

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub org.telegram.desktop

chmod 755 telegram-flatpak
mv telegram-flatpak "$HOME/.local/bin/"

exit 0
# vim: set ft=sh:
