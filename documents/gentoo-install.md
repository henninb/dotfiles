download minimal

https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation

1) boot > gentoo

2) ip addr show                # network configures automatically on gentoo for VirtualBox
2a) rc-service start dhcpcd
3) passwd root             # set root password
4) rc-service sshd start

5) putty login from remote

6) cfdisk (use dos)

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

#wget http://gentoo.ussg.indiana.edu/releases/amd64/autobuilds/current-stage3-amd64/stage3-amd64-20170302.tar.bz2
#wget http://gentoo.ussg.indiana.edu/releases/amd64/autobuilds/current-stage3-amd64/stage3-amd64-20181223T214502Z.tar.xz
#wget http://gentoo.ussg.indiana.edu/releases/amd64/autobuilds/current-stage3-amd64/stage3-amd64-20190103T214502Z.tar.xz
wget http://gentoo.ussg.indiana.edu/releases/amd64/autobuilds/current-stage3-amd64/stage3-amd64-20190115T214502Z.tar.xz

tar xvJpf stage3-*.tar.xz --xattrs --numeric-owner

# use flags
vi /mnt/gentoo/etc/portage/make.conf
MAKEOPTS="-j2"

sudo emerge ufed

# not required
sudo emerge eix

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

useradd -m -G users henninb
passwd henninb
passwd root

mount /dev/sda1 /boot

emerge-webrsync

echo "US/Central" > /etc/timezone
emerge --config sys-libs/timezone-data

vi /etc/fstab
/dev/sda1   /boot        ext2    defaults,noatime     0 2
/dev/sda2   /            ext4    noatime              0 1
  
/dev/cdrom  /mnt/cdrom   auto    noauto,user          0 0

vi /etc/conf.d/hostname

emerge --ask vim
emerge --ask sys-kernel/gentoo-sources
etc-update
emerge --ask sys-kernel/genkernel
emerge --ask sys-process/cronie
emerge --ask net-misc/netifrc
emerge --ask app-admin/sysklogd
emerge --ask net-misc/dhcpcd
emerge --ask sudo
emerge --ask sys-boot/grub:2

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

#not sure if this is required
#vi /etc/conf.d/modules
#e1000

#edit sudoers
vi /etc/sudoers

rc-update add sysklogd default
rc-update add cronie default
rc-update add dhcpcd default
rc-update add sshd default

usermod -aG wheel henninb

# will take a long time
genkernel all
tail -f /var/log/genkernel.log

ls /boot/kernel* /boot/initramfs*

grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
reboot


#optional
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

