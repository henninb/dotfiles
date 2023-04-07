#!/bin/sh

eselect kernel list

cd /boot
# Get a list of all kernel files except the newest two
latest_kernels=$(ls vmlinuz-* | sort -V | head -n -4)

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


# # Get a list of all kernel files in the directory
# cd /boot || exit
# kernel_files=$(ls vmlinuz-* System.map-* config-* initramfs-* 2>/dev/null)
#
# # Get the latest two kernel versions
# latest_kernels=$(echo "$kernel_files" | grep -oP "(\d+\.)+\d+" | sort -V | tail -n 2)
# echo i$latest_kernels
#
# # Remove the newest kernels from the list
# kernel_files=$(echo "$kernel_files" | grep -v "$latest_kernels")
#
# # Delete all kernel files older than the last two kernels
# # echo "$kernel_files" | xargs rm -f
#
#
# # get the list of kernel files sorted by modification time (newest first)
# # kernel_files=$(ls -t /boot/vmlinuz-* | head -n -2)
#
# if [ -z "$kernel_files" ]; then
#     echo "No kernel files found to remove."
#     exit 0
# fi
#
# echo "The following kernel files will be removed:"
# echo "$kernel_files"
#
# # prompt the user to confirm before deleting the files
# read -p "Are you sure you want to delete these files? [y/N] " confirm
# case $confirm in
#     [yY])
#         # delete the kernel files
#         # rm $kernel_files
#         echo "Kernel files removed."
#         ;;
#     *)
#         echo "Kernel files not removed."
#         ;;
# esac
# cd -

# old_kernel="5.18.9"
# # old_kernel="5.15.41"
# sudo rm -r "/usr/src/linux-${old_kernel}-gentoo" || echo "Failed to remove old kernel sources" || exit 1
# sudo rm -r /boot/*${old_kernel}-gentoo-x86_64* || echo "Failed to remove boot files" || exit 1
# sudo rm -r /lib/modules/${old_kernel}* || echo "Failed to remove modules" || exit 1
# ls -l /usr/src

exit 0
