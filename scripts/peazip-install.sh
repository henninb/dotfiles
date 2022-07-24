#!/bin/sh

if command -v pacman; then
  echo "archlinux"
  yay -S peazip-qt-bin
elif command -v emerge; then
  # echo "gentoo"
  # sudo emerge --update --newuse app-eselect/eselect-repository
  # sudo eselect repository enable bgo-overlay
  # sudo emaint sync -r bgo-overlay
  # sudo emerge --update --newuse app-arch/peazip

  curl -s "http://sourceforge.net/projects/peazip/files/5.6.0/peazip_portable-5.6.0.LINUX.x86_64.GTK2.tar.gz/download" -O "$HOME/tmp/peazip_portable-5.6.0.LINUX.x86_64.GTK2.tar.gz"
elif command -v apt; then
  echo "debian"
elif command -v xbps-install; then
  echo "void"
elif command -v eopkg; then
  echo "solus"
elif command -v dnf; then
  echo "fedora"
elif command -v brew; then
  echo "macos"
else
  echo "$OS is not yet implemented."
  exit 1
fi
