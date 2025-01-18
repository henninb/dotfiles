#!/bin/sh

wget 'https://github.com/Ultimaker/Cura/releases/download/5.9.0/UltiMaker-Cura-5.9.0-linux-X64.AppImage' -O /tmp/Cura.AppImage
chmod 755 /tmp/Cura.AppImage
mv /tmp/Cura.AppImage $HOME/.local/bin/

echo git clone https://github.com/Ultimaker/Cura.git

exit 0

# vim: set ft=sh:
