#!/bin/sh


if command -v pacman; then
  yay -S librewolf-bin
elif command -v emerge; then
  sudo emerge --update --newuse app-eselect/eselect-repository
  sudo eselect repository add librewolf git https://gitlab.com/librewolf-community/browser/gentoo.git
  sudo emaint -r librewolf sync
  sudo emerge --update --newuse librewolf-bin
elif command -v apt; then
  echo "debian"
elif command -v xbps-install; then
  echo "void"
elif command -v eopkg; then
  echo "solus"
elif command -v zypper; then
  echo "opensuse"
elif command -v dnf; then
  echo "fedora"
elif command -v zypper; then
  echo "opensuse"
elif command -v brew; then
  echo "macos"
else
  echo "$OS is not yet implemented."
  exit 1
fi

wget 'https://ocs-dl.fra1.cdn.digitaloceanspaces.com/data/files/1645459027/LibreWolf.x86_64.AppImage?response-content-disposition=attachment%3B%2520LibreWolf.x86_64.AppImage&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=RWJAQUNCHT7V2NCLZ2AL%2F20230214%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230214T004555Z&X-Amz-SignedHeaders=host&X-Amz-Expires=60&X-Amz-Signature=1a597334caeae548d0b51e8a2771c158cc0b7eaa1e9d1ee6b00a3f0c8c2050a4' -O "$HOME/Applications/LibreWolf.x86_64.AppImage"

chmod 755 "$HOME/Applications/LibreWolf.x86_64.AppImage"

exit 0

# vim: set ft=sh:
