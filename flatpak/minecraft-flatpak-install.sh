#!/bin/sh

cat > minecraft-flatpak <<EOF
#!/bin/sh

flatpak run com.mojang.Minecraft

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub com.mojang.Minecraft

chmod 755 minecraft-flatpak
mv minecraft-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:
