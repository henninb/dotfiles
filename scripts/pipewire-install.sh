#!/bin/sh

if command -v pacman; then
  echo "archlinux"
  sudo pacman --noconfirm --needed -S pipewire-pulse
  sudo systemctl enable pipewire-pulse --now
  exit 0
elif command -v emerge; then
  sudo emerge --update --newuse pipewire
elif command -v apt; then
  sudo apt install -y pipewire
elif command -v xbps-install; then
  sudo xbps-install -y polkit
  sudo ln -sfn /etc/sv/polkitd /var/service/polkitd
  # sudo ln -s /etc/sv/polkitd /etc/runit/runsvdir/current/
  sudo xbps-install -y xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-utils
  sudo xbps-install -y pipewire
  sudo mkdir -p /etc/pipewire
  sudo sed '/path.*=.*pipewire-media-session/s/{/#{/' /usr/share/pipewire/pipewire.conf | sudo tee /etc/pipewire/pipewire.conf
  sudo ln -sfn /etc/sv/pipewire /var/service/pipewire
  # sudo ln -s /etc/sv/pipewire /etc/runit/runsvdir/current/
elif command -v pkg; then
  echo "freebsd"
elif command -v eopkg; then
  echo "solus"
elif command -v zypper; then
  echo "opensuse"
elif command -v dnf; then
  echo "fedora"
elif command -v brew; then
  echo "macos"
else
  echo "$OS is not yet implemented."
  exit 1
fi

if command -v systemctl; then
  systemctl --user enable pipewire.socket pipewire-pulse.socket
  systemctl --user disable pipewire-media-session.service
  systemctl --user --force enable wireplumber.service
fi

pactl info

exit 0
