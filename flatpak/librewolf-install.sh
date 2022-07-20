#!/bin/sh

cat > librewolf-flatpak <<EOF
#!/bin/sh

flatpak run io.gitlab.librewolf-community

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub io.gitlab.librewolf-community

chmod 755 librewolf-flatpak
mv -v librewolf-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:
