#!/bin/sh

cat > vscodium-flatpak <<EOF
#!/bin/sh

flatpak run com.vscodium.codium

exit 0
# vim: set ft=sh:
EOF

if ! flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo; then
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

if ! flatpak --user -y install flathub com.vscodium.codium; then
  flatpak install flathub com.vscodium.codium
fi

chmod 755 vscodium-flatpak
mv -v vscodium-flatpak "$HOME/.local/bin"

exit 0
# vim: set ft=sh:
