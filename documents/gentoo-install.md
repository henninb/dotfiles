# gentoo install
download minimal

https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation

## boot
```
boot > gentoo
```

## network configures automatically on gentoo for VirtualBox and most baremetal
```
rc-service sshd start
ip addr show
```

## set root password
```
passwd root
```

## start sshd server
```
rc-service dhcpcd start
```

## remote ssh login from remote
```
ssh root@192.168.100.124
```

## partition the drive as show below (use dos)
```
cfdisk /dev/sda
```

/dev/sda1	ext2	(bootloader)	512M
/dev/sda2	ext4	Rest of the disk	Root partition

7) make the partitions
mkfs.ext2 -T small /dev/sda1
mkfs.ext4 -j -T small /dev/sda2


mkfs.ext2 -T small /dev/sdb1
mkfs.ext4 -j -T small /dev/sdb2

ntpd -q -g

mount /dev/sda2 /mnt/gentoo
cd /mnt/gentoo

## download stage3
```
wget http://gentoo.ussg.indiana.edu/releases/amd64/autobuilds/current-stage3-amd64/stage3-amd64-20200819T214503Z.tar.xz
```

## extract stage3 and be sure to verify success
```
tar xvJpf stage3-*.tar.xz --xattrs --numeric-owner
```

# use flags
vi /mnt/gentoo/etc/portage/make.conf
MAKEOPTS="-j2"
ACCEPT_LICENSE="*"

# not required
sudo emerge ufed

# not required
sudo emerge eix

## set the mirror list
mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf


cp -L /etc/resolv.conf /mnt/gentoo/etc/

mount -t proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev

chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) $PS1"

## user maintenence
```
useradd -m -G users henninb
passwd henninb
passwd root
usermod -aG wheel henninb
```

mount /dev/sda1 /boot

## run the webrsync (clock needs to be accurate and DNS needs to be functional)
```
emerge-webrsync
eselect news read
emerge --ask vim
```

## setup local time zone
```
echo "US/Central" > /etc/timezone
emerge --config sys-libs/timezone-data
```

vi /etc/fstab
/dev/sda1   /boot        ext2    defaults,noatime     0 2
/dev/sda2   /            ext4    noatime              0 1

/dev/cdrom  /mnt/cdrom   auto    noauto,user          0 0

vi /etc/conf.d/hostname

emerge --ask sys-kernel/gentoo-sources
etc-update
emerge --ask sys-kernel/genkernel
emerge --ask sys-process/cronie
emerge --ask net-misc/netifrc
emerge --ask app-admin/sysklogd
emerge --ask net-misc/dhcpcd
emerge --ask sudo
emerge --ask sys-boot/grub:2

ip addr show

vi /etc/conf.d/net
# virtualbox guest
config_eth0="dhcp"

# physical hardware
config_enp3s0="dhcp"

cd /etc/init.d
# virtualbox guest
ln -s net.lo net.eth0
rc-update add net.eth0 default

# physical hardware
ln -s net.lo net.enp3s0
rc-update add net.enp3s0 default

#edit sudoers
vi /etc/sudoers

rc-update add sysklogd default
rc-update add cronie default
rc-update add dhcpcd default
rc-update add sshd default

usermod -aG wheel henninb

# will take a long time (42 min)
genkernel all
tail -f /var/log/genkernel.log

## verify the kernel
ls /boot/vmlinuz* /boot/initramfs*

## grub install
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
reboot


## optional
#emerge --ask app-emulation/virtualbox-guest-additions
#gpasswd -a henninb vboxguest

# optional
#usermod -aG vboxsf henninb

# update source tree
emerge --sync

Desktop Not Installed

Username: osboxes
Password: osboxes.org


update all packages

emerge -auvDN world
emerge -a --depclean
revdepend-rebuild -i

