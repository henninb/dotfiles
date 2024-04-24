#!/bin/sh

cat << EOF > rythmbox-flatpak
#!/bin/sh

flatpak run org.gnome.Rhythmbox3

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub org.gnome.Rhythmbox3

chmod 755 rythmbox-flatpak
mv -v rythmbox-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:
