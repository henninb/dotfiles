#!/bin/sh

cat > "$HOME/tmp/hosts" <<'EOF'
[pfsense]
192.168.10.1

[ddwrt]
192.168.10.3

[proxmox]
192.168.10.4

[debian]
192.168.10.10

[gentoo]
192.168.10.103

[local]
localhost

[archlinux]
102.168.10.107
EOF

if command -v pacman; then
  echo "archlinux"
elif command -v emerge; then
  sudo emerge --update --newuse ansible
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

sudo usermod -aG ansible "$(id -un)"
sudo mkdir -p /etc/ansible
sudo mv "$HOME/tmp/hosts" /etc/ansible/hosts

exit 0

# vim: set ft=sh:
