#!/bin/sh

cat > spotify-flatpak <<EOF
#!/bin/sh

flatpak run com.spotify.Client

exit 0
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub com.spotify.Client

chmod 755 spotify-flatpak
mv spotify-flatpak "$HOME/.local/bin/"

exit 0
