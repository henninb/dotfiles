sudo parted /dev/nvme0n1 mklabel gpt
sudo parted /dev/nvme0n1 mkpart primary 1 1024
sudo parted /dev/nvme0n1 mkpart "EFI system" fat32 1MiB
sudo parted /dev/nvme0n1 mkpart primary 1024 100%

sudo parted /dev/nvme0n1 mkpart primary fat32 1 1024
sudo parted /dev/nvme0n1 set 1 esp on
# (parted) mkpart "EFI system partition" fat32 1MiB 301MiB
# (parted) set 1 esp on

sudo mkdir -p /mnt/voidlinux
sudo mkfs.fat -F32 /dev/nvme0n1p1
sudo mkfs.fat -F 32 -I /dev/nvme0n1p1
sudo mkfs.ext4 -b 4096 /dev/nvme0n1p2

sudo mount /dev/nvme0n1p2 /mnt/voidlinux
sudo mkdir -p /mnt/voidlinux/boot/efi/
sudo mount /dev/nvme0n1p1 /mnt/voidlinux/boot/efi/

wget https://repo-default.voidlinux.org/live/current/void-x86_64-ROOTFS-20221001.tar.xz
sudo tar xvf void-x86_64-ROOTFS-20221001.tar.xz -C /mnt/voidlinux

rm void-x86_64-ROOTFS-20221001.tar.xz

sudo cp /etc/resolv.conf /mnt/voidlinux/etc
sudo mount -t proc none /mnt/voidlinux/proc
sudo mount --rbind /dev /mnt/voidlinux/dev
sudo mount --rbind /sys /mnt/voidlinux/sys
sudo chroot /mnt/voidlinux

xbps-install -Suy xbps
xbps-install -uy
xbps-install -y base-system
xbps-remove -y base-voidstrap
xbps-reconfigure -f glibc-locales

cp /proc/mounts /etc/fstab
cleanup

xbps-install grub-x86_64-efi

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=voidlinux
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=voidlinux --verbose
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=voidlinux

# delete the efi with the label 0004
efibootmgr -Bb 0004

fsck -f -v /dev/nvme0n1p1

tune2fs -l /dev/nvme0n1p2
tune2fs -l /dev/nvme0n1p1

tune2fs: Bad magic number in super-block while trying to open /dev/nvme0n1p1
/dev/nvme0n1p1 contains a vfat file system

# tune2fs works only with ext2, ext3 and ext4 formatted partition.

parted -l
