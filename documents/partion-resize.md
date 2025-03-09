
lsblk -f
sudo e2fsck -f /dev/sdb2
sudo resize2fs /dev/sdb2 900G

tune2fs -l /dev/sdb2 |grep "^Block size:"
sudo tune2fs -l /dev/sdb2 |grep "^Block size:"
mkfs.ext4 -b 4096 /dev/sdb2
