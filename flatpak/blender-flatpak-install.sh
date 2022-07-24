#!/bin/sh

cat > blender-flatpak <<EOF
#!/bin/sh

flatpak run org.blender.Blender

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub org.blender.Blender

chmod 755 blender-flatpak
mv -v blender-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:
