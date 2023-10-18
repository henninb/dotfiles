# archlinux install

```
passwd
```

```
ssh root@192.168.122.25
```

## set the time
```
timedatectl set-ntp true
```


## partition the drive as show below (use dos)
```
parted /dev/sda mklabel msdos
parted /dev/sda mkpart primary 1 1024
parted /dev/sda set 1 boot on
parted /dev/sda mkpart primary 1024 100%
parted print devices
```

## partition the drive as show below (use gpt)
```
parted /dev/sda mklabel gpt
parted /dev/sda mkpart primary 1 1024
parted /dev/sda mkpart primary 1024 100%
parted print devices
```

## make the partitions (use dos)
```
mkfs.ext2 -T small /dev/sda1
mkfs.ext4 -j -b 4096 /dev/sda2
```

## make the partitions (use gpt)
```
mkfs.fat -F32 /dev/sda1
mkfs.ext4 -j -b 4096 /dev/sda2
```

## mount the partitions (use dos)
```
mount /dev/sda2 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot
```

## mount the partitions (use gpt)
```
mount /dev/sda2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
```

## install the arch base system
```
pacman -Sy archlinux-keyring
pacstrap /mnt base linux linux-firmware neovim vim dhcpcd openssh
```

## update the fstab
```
genfstab -U /mnt | tee -a /mnt/etc/fstab
```

## login to the chroot
```
arch-chroot /mnt
```

## set timezone
```
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
```

## set the hardware clock
```
hwclock --systohc
```

## setup network
```
pacman --noconfirm --needed -S dhcpcd
systemctl enable dhcpcd
pacman --noconfirm --needed -S openssh
systemctl enable sshd
```

## set the locale
```
cat << EOF >> /etc/locale.gen
en_US.UTF-8 UTF-8
EOF
locale-gen
```

## set the hostname
```
echo archlinux > /etc/hostname
```

## setup the kernel
```
mkinitcpio -P
```

## set the root password
```
passwd
```

## add user account
```
useradd -m -G users henninb
usermod -aG wheel henninb
passwd henninb
```

## install grub
```
pacman --noconfirm --needed -S grub
pacman --noconfirm --needed -S efibootmgr
```

## load grub on the boot drive (dos)
```
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
````

## load grub on the boot drive (gpt)
```
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=archlinux
grub-mkconfig -o /boot/grub/grub.cfg
````

## reboot system
```
reboot
```
