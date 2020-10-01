#!/bin/sh

cat > stellarium-flatpak <<EOF
#!/bin/sh

flatpak run org.stellarium.Stellarium

exit 0
EOF

flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub org.stellarium.Stellarium

chmod 755 stellarium-flatpak
mv stellarium-flatpak "$HOME/.local/bin/"

exit 0
