#!/bin/sh

wget https://github.com/AppImageCrafters/appimage-cli-tool/releases/download/v0.1.4/appimage-cli-tool-0.1.4-x86_64.AppImage -O appimage-cli
# wget https://github.com/AppImageCrafters/appimage-cli-tool/releases/latest/download/appimage-cli-tool -O appimage-cli
chmod 755 appimage-cli
sudo cp appimage-cli /usr/local/bin/
# sudo chmod +x /usr/local/bin/appimage-cli-tool

exit 0

# vim: set ft=sh:
