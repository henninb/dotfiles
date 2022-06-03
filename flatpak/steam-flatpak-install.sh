#!/bin/sh

cat > steam-flatpak <<EOF
#!/bin/sh

flatpak run com.valvesoftware.Steam

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub com.valvesoftware.Steam
echo flatpak list

chmod 755 steam-flatpak
mv steam-flatpak "$HOME/.local/bin/"

exit 0
# vim: set ft=sh:
