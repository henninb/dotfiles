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
parted /dev/sda  mklabel msdos
parted /dev/sda mkpart primary 1 1024
parted /dev/sda set 1 boot on
parted /dev/sda mkpart primary 1024 100%
```


## make the partitions
```
mkfs.ext2 -T small /dev/sda1
mkfs.ext4 -j -T small /dev/sda2
```

## mount the partitions
```
mkdir -p /mnt/boot
mount /dev/sda2 /mnt
mount /dev/sda1 /mnt/boot
```

## install the arch base system
```
pacman -Sy archlinux-keyring
pacstrap /mnt base linux linux-firmware
```

## update the fstab
```
genfstab -U /mnt >> /mnt/etc/fstab
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
TBD
pacman -S dhcpcd
systemctl enable dhcpcd
pacman -S openssh
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
pacman -S grub
```

## load grub on the boot drive
```
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
````

## reboot system
```
reboot
```
