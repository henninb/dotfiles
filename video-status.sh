#!/bin/sh

sudo pacman -S vdpauinfo
sudo pacman -S mesa-vdpau
sudo pacman -S libva-vdpau-driver libvdpau-va-gl

vdpauinfo
vainfo

echo mesa-vdpau and also libva-mesa-driver
lspci |grep VGA

echo VDPAU and VAAPI.

exit 0
