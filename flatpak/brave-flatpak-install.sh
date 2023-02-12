#!/bin/sh

cat > brave-flatpak <<EOF
#!/bin/sh

flatpak run com.brave.Browser

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub com.brave.Browser

chmod 755 brave-flatpak
mv brave-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:
