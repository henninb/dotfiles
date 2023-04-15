#!/bin/sh

eselect kernel list

cd /boot
# Get a list of all kernel files except the newest two
latest_kernels=$(ls vmlinuz-* | sort -V | head -n -2)

# Include System.map, config, and initramfs files in the deletion process
for kernel in $latest_kernels; do
  # echo $kernel
  # echo System.map-${kernel#vmlinuz-}*
  # echo config-${kernel#vmlinuz-}*
  # echo initramfs-${kernel#vmlinuz-}*.img
  sudo rm $kernel
  sudo rm System.map-${kernel#vmlinuz-}*
  sudo rm config-${kernel#vmlinuz-}*
  sudo rm initramfs-${kernel#vmlinuz-}*.img
done

echo "Old kernel files removed successfully."
cd -

exit 0

# vim: set ft=sh:
