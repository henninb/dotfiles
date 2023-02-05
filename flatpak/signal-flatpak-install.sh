#!/bin/sh

cat > signal-flatpak <<EOF
#!/bin/sh

flatpak run org.signal.Signal

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak -y --user install flathub org.signal.Signal

chmod 755 signal-flatpak
mv signal-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:
