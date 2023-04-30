#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S pipewire-media-session
  doas pacman --noconfirm --needed -S pipewire
  doas pacman --noconfirm --needed -S pipewire-pulse
  doas systemctl enable pipewire-pulse --now
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse pipewire
  sudo emerge --update --newuse media-video/wireplumber
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y pipewire
  doas apt install -y pipewire-pulse
  doas usermod -a -G audio $(whoami)
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y polkit
  sudo ln -sfn /etc/sv/polkitd /var/service/polkitd
  # sudo ln -s /etc/sv/polkitd /etc/runit/runsvdir/current/
  doas xbps-install -y xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-utils
  doas xbps-install -y pipewire
  sudo mkdir -p /etc/pipewire
  sudo sed '/path.*=.*pipewire-media-session/s/{/#{/' /usr/share/pipewire/pipewire.conf | sudo tee /etc/pipewire/pipewire.conf
  sudo ln -sfn /etc/sv/pipewire /var/service/pipewire
elif [ "$OS" = "FreeBSD" ]; then
  echo "freebsd"
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo opensuse
elif [ "$OS" = "Fedora Linux" ]; then
  echo "fedora"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
else
  echo "$OS is not yet implemented."
  exit 1
fi

if command -v systemctl; then
  systemctl --user enable pipewire.socket 
  systmeclt --user enable pipewire-pulse.socket
  systemctl --user disable pipewire-media-session.service
  systemctl --user --force enable wireplumber.service
fi

pactl info

exit 0
# vim: set ft=sh:
