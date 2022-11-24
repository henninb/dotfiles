#!/bin/sh

cat << EOF > "$HOME/tmp/registries.conf"
[registries.search]
registries = ['docker.io', 'quay.io', 'registry.access.redhat.com']
registries = ['docker.io']
EOF

if command -v pacman; then
  sudo pacman --noconfirm --needed -S podman
  sudo pacman --noconfirm --needed -S slirp4netns
  # sudo usermod --add-subuids 10000-75535 henninb
  # sudo usermod --add-subgids 10000-75535 henninb
  echo henninb:10000:65536 | sudo tee -a /etc/subuid
  echo henninb:10000:65536 | sudo tee -a /etc/subgid
elif command -v emerge; then
  sudo emerge --update --newuse podman
  sudo emerge --update --newuse slirp4netns
  sudo usermod --add-subuids 1065536-1131071 "$(whoami)"
  sudo usermod --add-subgids 1065536-1131071 "$(whoami)"
elif [ -x "$(command -v apt)" ]; then
  echo "debian"
elif [ -x "$(command -v xbps-install)" ]; then
  sudo xbps-install -y podman
elif [ -x "$(command -v eopkg)" ]; then
  echo "solus"
elif [ -x "$(command -v dnf)" ]; then
  echo "fedora"
elif [ -x "$(command -v brew)" ]; then
  echo "macoos"
else
  echo "$OS is not yet implemented."
  exit 1
fi

sudo cp -v /etc/containers/policy.json.example /etc/containers/policy.json

sudo touch /etc/subuid /etc/subgid
# cat /etc/sysctl.d/userns.conf
sudo sysctl kernel.unprivileged_userns_clone=1
sysctl kernel.unprivileged_userns_clone

usermod --add-subuids 100000-165535 --add-subgids 100000-165535 "$(id -un)"

sudo mv -v "$HOME/tmp/registries.conf" /etc/containers/registries.conf

exit 0

# vim: set ft=sh:
