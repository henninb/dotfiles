#!/bin/sh

VER=3.0.24
wget https://github.com/standardnotes/desktop/releases/download/v${VER}/standard-notes-${VER}-x86_64.AppImage
chmod 755 standard-notes-${VER}-x86_64.AppImage
mv standard-notes-${VER}-x86_64.AppImage $HOME/.local/bin/standard-notes

exit 0
