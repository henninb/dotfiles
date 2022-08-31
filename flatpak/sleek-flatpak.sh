#!/bin/sh

cat > sleek-flatpak <<EOF
#!/bin/sh

flatpak run com.github.ransome1.sleek

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if ! flatpak --user -y install com.github.ransome1.sleek; then
  flatpak install flathub com.github.ransome1.sleek
fi
chmod 755 sleek-flatpak
mv -v sleek-flatpak "$HOME/.local/bin"

exit 0
# vim: set ft=sh:
