#!/bin/sh

sudo xbps-install -y podman

sudo pacman --noconfirm --needed -S podman
# sudo usermod --add-subuids 10000-75535 henninb
# sudo usermod --add-subgids 10000-75535 henninb

echo henninb:10000:65536 | sudo tee -a /etc/subuid
echo henninb:10000:65536 | sudo tee -a /etc/subgid

sudo touch /etc/subuid /etc/subgid
# cat /etc/sysctl.d/userns.conf
sudo sysctl kernel.unprivileged_userns_clone=1
sysctl kernel.unprivileged_userns_clone

usermod --add-subuids 100000-165535 --add-subgids 100000-165535 henninb

echo sudo vim /etc/containers/registries.conf.

echo [registries.search]
echo registries = ['docker.io', 'quay.io', 'registry.access.redhat.com']
echo registries = ['docker.io']

exit 0

# vim: set ft=sh
