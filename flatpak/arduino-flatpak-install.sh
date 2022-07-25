#!/bin/sh

cat  << EOF > arduino-flatpak
#!/bin/sh

flatpak run cc.arduino.arduinoide

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if ! flatpak --user -y install flathub cc.arduino.arduinoide; then
  flatpak -y install flathub cc.arduino.arduinoide
fi

chmod 755 arduino-flatpak
mv arduino-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh: