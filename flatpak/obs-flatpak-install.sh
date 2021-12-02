#!/bin/sh

cat > obs-flatpak <<EOF
#!/bin/sh

flatpak run com.obsproject.Studio

exit 0
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if ! flatpak --user -y install flathub com.obsproject.Studio; then
  flatpak -y install flathub com.obsproject.Studio
fi

chmod 755 obs-flatpak
mv obs-flatpak "$HOME/.local/bin/"

exit 0
