#!/bin/sh

if [ -x "$(command -v pacman)" ]; then
  sudo pacman --noconfirm --needed -S podman
  # sudo usermod --add-subuids 10000-75535 henninb
  # sudo usermod --add-subgids 10000-75535 henninb
  echo henninb:10000:65536 | sudo tee -a /etc/subuid
  echo henninb:10000:65536 | sudo tee -a /etc/subgid
elif [ -x "$(command -v emerge)" ]; then
  sudo emerge --update --newuse podman
  sudo usermod --add-subuids 1065536-1131071 "$(whoami)"
  sudo usermod --add-subgids 1065536-1131071 "$(whoami)"
elif [ -x "$(command -v apt)" ]; then
  echo
elif [ -x "$(command -v xbps-install)" ]; then
  sudo xbps-install -y podman
elif [ -x "$(command -v eopkg)" ]; then
  echo
elif [ -x "$(command -v dnf)" ]; then
  echo
elif [ -x "$(command -v brew)" ]; then
  echo
else
  echo "$OS is not yet implemented."
  exit 1
fi

sudo touch /etc/subuid /etc/subgid
# cat /etc/sysctl.d/userns.conf
sudo sysctl kernel.unprivileged_userns_clone=1
sysctl kernel.unprivileged_userns_clone

usermod --add-subuids 100000-165535 --add-subgids 100000-165535 "$(id -un)"

echo sudo vim /etc/containers/registries.conf.

echo [registries.search]
echo registries = ['docker.io', 'quay.io', 'registry.access.redhat.com']
echo registries = ['docker.io']

exit 0

# vim: set ft=sh
