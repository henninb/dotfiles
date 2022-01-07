#!/bin/sh

sudo pacman -S --noconfirm podman
# sudo usermod --add-subuids 10000-75535 henninb
# sudo usermod --add-subgids 10000-75535 henninb

echo henninb:10000:65536 | sudo tee -a /etc/subuid
echo henninb:10000:65536 | sudo tee -a /etc/subgid

cat /etc/sysctl.d/userns.conf

exit 0
