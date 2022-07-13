#!/bin/sh

eselect kernel list

old_kernel="5.18.9"
# old_kernel="5.15.41"
sudo rm -r "/usr/src/linux-${old_kernel}-gentoo" || echo "Failed to remove old kernel sources" || exit 1
sudo rm -r /boot/*${old_kernel}-gentoo-x86_64* || echo "Failed to remove boot files" || exit 1
sudo rm -r /lib/modules/${old_kernel}* || echo "Failed to remove modules" || exit 1
ls -l /usr/src

exit 0
