#!/bin/sh

if command -v pacman; then
  # echo "archlinux"
  yay --noconfirm --needed -S snapd
  sudo systemctl enable --now snapd
elif command -v emerge; then
  sudo emerge --update --newus sys-apps/systemd
  sudo emerge --update --newus sys-apps/apparmor
  echo GRUB_CMDLINE_LINUX_DEFAULT="apparmor=1 security=apparmor" >> /etc/default/grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  sudo emerge --update --newus app-containers/snapd
  sudo gpasswd --add "$(id -un)" adm
  sudo systemctl enable --now snapd
  sudo systemctl enable --now snapd.socket
  sudo systemctl enable --now snapd.apparmor
elif command -v apt; then
  echo "debian"
elif command -v xbps-install; then
  echo "void"
elif command -v eopkg; then
  echo "solus"
elif command -v dnf; then
  echo "fedora"
  sudo dnf install -y snapd
  sudo systemctl enable --now snapd
elif command -v brew; then
  echo "macos"
else
  echo "$OS is not yet implemented."
  exit 1
fi

sudo snap install hello-world
sudo snap install sosumi

exit 0
