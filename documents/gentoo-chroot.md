# chroot gentoo

```
mkdir -p /mnt/gentoo
mount /dev/vda2 /mnt/gentoo
cd /mnt/gentoo

mount -t proc none /mnt/gentoo/proc
mount --rbind /dev /mnt/gentoo/dev
mount --rbind /sys /mnt/gentoo/sys

chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) $PS1"

mount /dev/vda1 /boot
lsblk -f

/dev/vda2: UUID="db686a46-9996-41d4-ada6-24f37119f121" BLOCK_SIZE="1024" TYPE="ext4" PARTUUID="6ddb5897-02"
/dev/vda1: UUID="2c0c9944-2ecf-48b1-bf88-2cd4632505d7" BLOCK_SIZE="1024" TYPE="ext2" PARTUUID="6ddb5897-01"
```
