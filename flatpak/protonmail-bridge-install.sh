#!/bin/sh

cat > protonmail-bridge-flatpak <<EOF
#!/bin/sh

flatpak run --filesystem=home ch.protonmail.protonmail-bridge

exit 0
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if ! flatpak --user -y install flathub ch.protonmail.protonmail-bridge; then
  flatpak -y install flathub ch.protonmail.protonmail-bridge
fi

chmod 755 protonmail-bridge-flatpak
mv protonmail-bridge-flatpak "$HOME/.local/bin/"

exit 0
