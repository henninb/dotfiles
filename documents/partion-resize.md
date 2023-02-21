# resize partition
lsblk -f
sudo e2fsck -f /dev/sdb2
sudo resize2fs /dev/sdb2 900G
