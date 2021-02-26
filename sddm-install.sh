#!/bin/sh

sudo pacman -S sddm
sudo systemctl enable sddm.service -f

sudo systemctl disable lightdm

exit 0
