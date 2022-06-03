#!/bin/sh

cat > bottles-flatpak <<EOF
#!/bin/sh

flatpak run com.usebottles.bottles

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.usebottles.bottles
if ! flatpak --user -y install flathub com.usbottles.bottles; then
  flatpak install flathub com.usbottles.bottles
fi
chmod 755 bottles-flatpak
mv -v bottles-flatpak "$HOME/.local/bin"

exit 0

# vim: set ft=sh:
