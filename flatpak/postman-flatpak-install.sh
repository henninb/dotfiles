#!/bin/sh

cat > postman-flatpak <<EOF
#!/bin/sh

flatpak run --filesystem=home com.getpostman.Postman

exit 0

# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if ! flatpak --user -y install flathub com.getpostman.Postman; then
  flatpak -y install flathub com.getpostman.Postman
fi

chmod 755 postman-flatpak
mv postman-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:
