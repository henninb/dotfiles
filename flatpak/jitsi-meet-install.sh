#!/bin/sh

cat > jitsi-flatpak <<EOF
#!/bin/sh

flatpak run org.jitsi.jitsi-meet

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub org.jitsi.jitsi-meet

chmod 755 jitsi-flatpak
mv jitsi-flatpak "$HOME/.local/bin/"

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub org.jitsi.jitsi-meet
echo flatpak run org.jitsi.jitsi-meet

exit 0

# vim: set ft=sh:
