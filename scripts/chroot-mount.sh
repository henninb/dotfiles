#!/bin/sh

if [ $# -ne 1 ] && [ $# -ne 2 ]; then
  echo "Usage: $0 <os> [disk]"
  echo "gentoo|archlinux|fedora|voidlinux|ubuntu|opensuse"
  echo "disk sdc sdb"
  exit 1
fi

os=$1
disk=$2

if [ "$OS" = "FreeBSD" ]; then
  echo FreeBSD

  if [ "$os" = "archlinux" ]; then
    echo Archlinux on FreeBSD
    sudo mkdir -p /mnt/archlinux
    doas mount -t ext2fs /dev/ada1p2 /mnt/archlinux
    sudo chroot /mnt/archlinux/ /bin/su - "$(id -un)"
  fi
  exit 1
fi

if command -v camcontrol; then
  sudo camcontrol devlist
  gpart show ada0
  sudo pkg install -y fusefs-lkl
  sudo lklfuse -o type=ext4 /dev/ada0p3 /mnt/archlinux
fi

# lsblk -o NAME,UUID
# sudo blkid
lsblk -o UUID,MOUNTPOINT > $HOME/tmp/lsblk.txt
echo 'UUID=7C20699920695B62  /mnt/external    ntfs            rw 0 1'
echo 'sudo mount -t ntfs-3g /dev/ada0p1 /mnt/external'
echo 'ntfs-3g /dev/da0s1 /mnt -o ro,uid=1001,gid=1001'

if [ "$os" = "voidlinux" ]; then
  root=b128a037-b64f-4cce-9d8a-68a3115b4523
  efi=18ED-5063
  if [ "$(grep -c "$root /mnt/voidlinux" $HOME/tmp/lsblk.txt)" -ne 1 ]; then
    sudo mkdir -p /mnt/voidlinux
    sudo mount "UUID=$root" /mnt/voidlinux
    sudo mkdir -p /mnt/voidlinux/boot/efi
    sudo mount -t proc none /mnt/voidlinux/proc
    sudo mount --rbind /dev /mnt/voidlinux/dev
    sudo mount --rbind /sys /mnt/voidlinux/sys
    sudo mount UUID=$efi /mnt/voidlinux/boot/efi
  else
    echo already mounted
  fi
  echo 'export PS1="(voidlinux-chroot) $PS1"'
  sudo chroot /mnt/voidlinux /bin/su - "$(id -un)"
elif [ "$os" = "gentoo" ]; then
  root=6d8ab46d-3e64-4ee5-b6e2-940433d01d56
  efi=CCF7-57C5
  if [ "$(grep -c "$root /mnt/gentoo" $HOME/tmp/lsblk.txt)" -ne 1 ]; then
    sudo mkdir -p /mnt/gentoo
    sudo mount "UUID=$root" /mnt/gentoo
    sudo mkdir -p /mnt/gentoo/boot/efi
    # cd /mnt/gentoo || exit
    sudo mount -t proc none /mnt/gentoo/proc
    sudo mount --rbind /dev /mnt/gentoo/dev
    sudo mount --rbind /sys /mnt/gentoo/sys
    sudo mount UUID=$efi /mnt/gentoo/boot/efi
  else
    echo already mounted
  fi
  echo 'export PS1="(gentoo-chroot) $PS1"'
  sudo chroot /mnt/gentoo /bin/su - "$(id -un)"
  #sudo chroot /mnt/gentoo /bin/zsh -c "su - "$(id -un)" -c 'touch /tmp/chroot'; su - "$(id -un)""
elif [ "$os" = "fedora" ]; then
  root=1f225586-7750-40b7-8b00-19b4b40f1d68
  efi=3504-1319
  if [ "$(grep -c "$root /mnt/fedora" $HOME/tmp/lsblk.txt)" -ne 1 ]; then
    sudo mkdir -p /mnt/fedora
    sudo mount "UUID=$root" /mnt/fedora
    sudo mkdir -p /mnt/fedora/boot/efi
    sudo mount -t proc none /mnt/fedora/proc
    sudo mount --rbind /dev /mnt/fedora/dev
    sudo mount --rbind /sys /mnt/fedora/sys
    # sudo mount --bind /etc/resolv.conf /mnt/fedora//run/systemd/resolve/stub-resolv.conf
    # sudo mount --bind /etc/resolv.conf /mnt/fedora/etc/resolv.conf
    sudo mount UUID=$efi /mnt/fedora/boot/efi
  else
    echo already mounted
  fi
  echo 'export PS1="(fedora-chroot) $PS1"'
  sudo chroot /mnt/fedora /bin/su - "$(id -un)"
elif [ "$os" = "freebsd" ]; then
  root=
  efi=
  sudo mkdir -p /mnt/freebsd
  sudo mount -t ufs -o ro,ufstype=ufs2 /dev/nvme0n1p3 /mnt/freebsd
  # sudo mkdir -p /mnt/chroot-freebsd
  # sudo cp -R /mnt/freebsd/* /mnt/chroot-freebsd
  # sudo mknod -m 666 /mnt/chroot-freebsd/dev/null c 1 3
  # sudo mknod -m 666 /mnt/chroot-freebsd/dev/random c 1 8
  # sudo mount -t proc proc /mnt/chroot-freebsd/proc
  # sudo mount -t sysfs sys /mnt/chroot-freebsd/sys
  # sudo mount -o bind /dev /mnt/chroot-freebsd/dev
  # sudo mount -t devpts pts /mnt/chroot-freebsd/dev/pts
  # sudo mount -o bind /dev /mnt/freebsd/dev
  # sudo mount -t procfs proc /mnt/freebsd/proc
  # sudo mount -t fdescfs fdesc /mnt/freebsd/dev/fd
  # sudo mount -t tmpfs tmpfs /mnt/freebsd/tmp
elif [ "$os" = "mint" ]; then
  root=440b99ec-d5ee-47e3-aab2-8235faac7097
  efi=3504-1319
  if [ "$(grep -c "$root /mnt/mint" $HOME/tmp/lsblk.txt)" -ne 1 ]; then
    sudo mkdir -p /mnt/mint
    sudo mount "UUID=$root" /mnt/mint
    sudo mkdir -p /mnt/mint/boot/efi
    sudo mount -t proc none /mnt/mint/proc
    sudo mount --rbind /dev /mnt/mint/dev
    sudo mount --rbind /sys /mnt/mint/sys
    sudo mount UUID=$efi /mnt/mint/boot/efi
  else
    echo already mounted
  fi
  echo 'export PS1="(mint-chroot) $PS1"'
  sudo chroot /mnt/mint /bin/su - "$(id -un)"
elif [ "$os" = "opensuse" ]; then
  root=e21df22e-e314-43b0-b8fb-941a5c11528f
  efi=94DB-18F3
  if [ "$(grep -c "$root /mnt/opensuse" $HOME/tmp/lsblk.txt)" -ne 1 ]; then
    sudo mkdir -p /mnt/opensuse
    sudo mount "UUID=$root" /mnt/opensuse
    sudo mkdir -p /mnt/opensuse/boot/efi
    sudo mount -t proc none /mnt/opensuse/proc
    sudo mount --rbind /dev /mnt/opensuse/dev
    sudo mount --rbind /sys /mnt/opensuse/sys
    sudo mount UUID=$efi /mnt/opensuse/boot/efi
  else
    echo already mounted
  fi
  echo 'export PS1="(opensuse-chroot) $PS1"'
  sudo chroot /mnt/opensuse /bin/su - "$(id -un)"
# elif [ "$os" = "fedora" ]; then
#   root=
#   efi=
#   if [ "$(grep -c "722c5ee8-b300-4b51-86de-9221ebabc617 /mnt/fedora" $HOME/tmp/lsblk.txt)" -ne 1 ]; then
#     sudo mkdir -p /mnt/fedora
#     sudo mount UUID=722c5ee8-b300-4b51-86de-9221ebabc617 /mnt/fedora
#     sudo mount UUID=906ecda7-1224-4533-9c0b-a5c070d3e68b /mnt/fedora/root/boot
#     # cd /mnt/fedora || exit
#     sudo mount --rbind /mnt/fedora/home /mnt/fedora/root/home
#     sudo mount -t proc none /mnt/fedora/root/proc
#     sudo mount --rbind /dev /mnt/fedora/root/dev
#     sudo mount --rbind /sys /mnt/fedora/root/sys
#     sudo mount --rbind /run /mnt/fedora/root/run
#     sudo mount UUID=1EF4-FD52 /mnt/fedora/root/boot/efi
#   else
#     echo already mounted
#   fi
#   echo 'export PS1="(fedora-chroot) $PS1"'
#   sudo chroot /mnt/fedora/root /bin/su - "$(id -un)"
elif [ "$os" = "ubuntu" ]; then
  root=a7bb907f-6870-40a6-af47-ac881e72caf2
  efi=F577-6798
  if [ "$(grep -c "$root /mnt/ubuntu" $HOME/tmp/lsblk.txt)" -ne 1 ]; then
    sudo mkdir -p /mnt/ubuntu
    sudo mount "UUID=$root" /mnt/ubuntu
    sudo mkdir -p /mnt/ubuntu/boot/efi
    # cd /mnt/ubuntu || exit
    sudo mount -t proc none /mnt/ubuntu/proc
    sudo mount --rbind /dev /mnt/ubuntu/dev
    sudo mount --rbind /sys /mnt/ubuntu/sys
    sudo mount UUID=$efi /mnt/ubuntu/boot/efi
  else
    echo already mounted
  fi
  echo 'export PS1="(ubuntu-chroot) $PS1"'
  sudo chroot /mnt/ubuntu /bin/su - "$(id -un)"
elif [ "$os" = "archlinux" ]; then
  root=72ad4c57-06c1-41d6-a72f-34000c848126
  efi=F577-6798
  if [ "$(grep -c "$root /mnt/archlinux" $HOME/tmp/lsblk.txt)" -ne 1 ]; then
    sudo mkdir -p /mnt/archlinux
    sudo mount "UUID=$root" /mnt/archlinux
    sudo mkdir -p /mnt/archlinux/boot/efi
    sudo mount -t proc none /mnt/archlinux/proc
    sudo mount --rbind /dev /mnt/archlinux/dev
    sudo mount --rbind /sys /mnt/archlinux/sys
    sudo mount UUID=$efi /mnt/archlinux/boot/efi
  else
    echo already mounted
  fi
  export CHROOT=/mnt/archlinux
  echo 'export PS1="(archlinux-chroot) $PS1"'
  # sudo chroot /mnt/archlinux /bin/su - "$(id -un)"
  sudo chroot /mnt/archlinux zsh -c "su - "$(id -un)" -c 'touch /tmp/chroot'; su - "$(id -un)""
  # /usr/bin/sudo -E CHROOT=/mnt/archlinux chroot /mnt/archlinux su - henninb
  # doas chroot /mnt/archlinux su - "$(id -un)" -c 'export CHROOT=/mnt/archlinux; pwd'
  # doas chroot /mnt/archlinux su - "$(id -un)" -c 'export CHROOT=/mnt/archlinux $CHROOT'
  # /usr/bin/sudo -E CHROOT=/mnt/archlinux chroot /mnt/archlinux su - "$(id -un)"
  #sudo chroot /mnt/archlinux /bin/su -l "$(id -un)" -c '. chroot-prompt'
  #sudo chroot /mnt/archlinux /bin/su -l "$(id -un)" -c '. /home/henninb/.local/bin/chroot-prompt'
  # sudo chroot /mnt/archlinux su - "$(id -un)" -c 'zsh -c  ". chroot-prompt" && zsh'
  # sudo chroot /mnt/archlinux su - "$(id -un)" -c 'export CHROOT=/mnt/archlinux; pwd'
else
  echo "chose the correct os."
fi

exit 0
