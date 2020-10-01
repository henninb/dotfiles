#!/bin/sh

cat > discord-flatpak <<EOF
#!/bin/sh

flatpak run com.discordapp.Discord

exit 0
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.discordapp.Discord
#flatpak install -y --user flathub com.discordapp.Discord
chmod 755 discord-flatpak
mv discord-flatpak "$HOME/.local/bin/"

exit 0
