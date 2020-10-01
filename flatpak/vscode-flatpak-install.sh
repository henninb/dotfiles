#!/bin/sh

cat > vscode-flatpak <<EOF
#!/bin/sh

flatpak run com.visualstudio.code

exit 0
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if ! flatpak --user -y install flathub com.visualstudio.code; then
  flatpak install flathub com.visualstudio.code
fi
chmod 755 vscode-flatpak
mv -v vscode-flatpak "$HOME/.local/bin"

exit 0
