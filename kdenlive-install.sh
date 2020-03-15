#!/bin/sh

wget https://files.kde.org/kdenlive/release/kdenlive-19.12.1-x86_64.appimage
chmod 755 kdenlive-19.12.1-x86_64.appimage
mv kdenlive-19.12.1-x86_64.appimage "$HOME/.local/bin/kdenlive"

exit 0
