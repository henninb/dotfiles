#!/bin/sh

cat > slack-flatpak <<EOF
#!/bin/sh

flatpak run com.slack.Slack

exit 0
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.slack.Slack
chmod 755 slack-flatpak
mv slack-flatpak "$HOME/.local/bin/"

exit 0
