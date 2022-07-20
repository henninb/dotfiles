# chroot gentoo

```
mkdir -p /mnt/gentoo
mount /dev/sda2 /mnt/gentoo
cd /mnt/gentoo

mount -t proc none /mnt/gentoo/proc
mount --rbind /dev /mnt/gentoo/dev
mount --rbind /sys /mnt/gentoo/sys

chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) $PS1"

mount /dev/sda1 /boot
lsblk -f

├─sda1 ext2     1.0                          93854486-ecb9-4f51-82ea-16363d4c921e
└─sda2 ext4     1.0                          947dd6e2-9d62-42c3-bc4c-57415b8c6403
```
