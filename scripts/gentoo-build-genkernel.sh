#!/bin/sh

ls -1 /usr/portage/sys-kernel/gentoo-sources/*.ebuild
echo sudo emerge sys-kernel/gentoo-sources:5.18.10
eselect kernel list
echo sudo eselect kernel set 4
echo sudo genkernel all
echo sudo grub-install /dev/sda
echo sudo grub-mkconfig -o /boot/grub/grub.cfg

exit 0
# vim: set ft=sh:
