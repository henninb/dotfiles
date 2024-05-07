#!/bin/sh

cat << EOF > rhythmbox-flatpak
#!/bin/sh

flatpak run org.gnome.Rhythmbox3

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub org.gnome.Rhythmbox3

chmod 755 rhythmbox-flatpak
mv -v rhythmbox-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:
