#!/bin/sh


cat << EOF > "$HOME/tmp/doas.conf"
permit nopass henninb as root
EOF

if command -v pacman; then
  sudo pacman --noconfirm --needed -S doas
elif command -v emerge; then
  sudo emerge --update --newuse doas
elif command -v apt; then
  echo "debian"
elif command -v xbps-install; then
  sudo xbps-install -y doas
elif command -v eopkg; then
  echo "solus"
elif command -v dnf; then
  sudo dnf install -y doas
elif command -v brew; then
  echo "macos"
else
  echo "$OS is not yet implemented."
  exit 1
fi

sudo mv -v "$HOME/tmp/doas.conf" /etc/doas.conf
sudo chown root:root /etc/doas.conf
sudo chmod 600 /etc/doas.conf

exit 0
