#!/bin/sh

eselect kernel list
echo

cd /boot
# Get a list of all kernel files except the newest two
OLD_KERNELS=$(ls vmlinuz-* | sort -V | head -n -2)
NEW_KERNELS=$(ls vmlinuz-* | sort -V | tail -n 2)

echo "keeping these kernels"
echo "${NEW_KERNELS}"
echo
echo "delete these kernels"
echo "${OLD_KERNELS}"

while true; do
    echo "Press 'y' to continue..."
    read -r input
    if [ "$input" = "y" ]; then
        break
    else
        echo "Invalid input. Please press 'y' to continue."
    fi
done

echo "Continuing with removing the old kernels"

# Include System.map, config, and initramfs files in the deletion process
for kernel in $OLD_KERNELS; do
  # echo $kernel
  # echo System.map-${kernel#vmlinuz-}*
  # echo config-${kernel#vmlinuz-}*
  # echo initramfs-${kernel#vmlinuz-}*.img
  doas rm $kernel
  doas rm System.map-${kernel#vmlinuz-}**
  doas rm config-${kernel#vmlinuz-}**
  sudo rm initramfs-${kernel#vmlinuz-}*.img
done

doas grub-mkconfig -o /boot/grub/grub.cfg

echo "Old kernel files removed successfully."
cd -

exit 0

# vim: set ft=sh:
