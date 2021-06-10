#!/bin/sh

cat > vscodium-flatpak <<EOF
#!/bin/sh

flatpak run com.vscodium.codium

exit 0
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if ! flatpak --user -y install flathub com.vscodium.codium; then
  flatpak install flathub com.vscodium.codium
fi
chmod 755 vscodium-flatpak
mv -v vscodium-flatpak "$HOME/.local/bin"

exit 0
