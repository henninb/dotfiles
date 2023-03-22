#!/bin/sh

if [ $# -ne 1 ] && [ $# -ne 2 ]; then
  echo "Usage: $0 <os> [disk]"
  echo "gentoo|archlinux|fedora|voidlinux|ubuntu|opensuse"
  echo "disk sdc sdb"
  exit 1
fi

os=$1
disk=$2

if command -v camcontrol; then
  sudo camcontrol devlist
  gpart show ada0
  sudo pkg install -y fusefs-lkl
  sudo lklfuse -o type=ext4 /dev/ada0p3 /mnt/archlinux
fi

lsblk -o UUID,MOUNTPOINT > $HOME/tmp/lsblk.txt

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
elif [ "$os" = "fedora-new" ]; then
  root=11516130-fe8e-4c13-9c22-3c237073a2eb
  efi=18ED-5063
  if [ "$(grep -c "$root /mnt/fedora-new" $HOME/tmp/lsblk.txt)" -ne 1 ]; then
    sudo mkdir -p /mnt/fedora-new
    sudo mount "UUID=$root" /mnt/fedora-new
    sudo mkdir -p /mnt/fedora-new/boot/efi
    sudo mount -t proc none /mnt/fedora-new/proc
    sudo mount --rbind /dev /mnt/fedora-new/dev
    sudo mount --rbind /sys /mnt/fedora-new/sys
    sudo mount UUID=$efi /mnt/fedora-new/boot/efi
  else
    echo already mounted
  fi
  echo 'export PS1="(fedora-chroot) $PS1"'
  sudo chroot /mnt/fedora-new /bin/su - "$(id -un)"
elif [ "$os" = "mint" ]; then
  root=
  efi=
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
elif [ "$os" = "fedora" ]; then
  root=
  efi=
  if [ "$(grep -c "722c5ee8-b300-4b51-86de-9221ebabc617 /mnt/fedora" $HOME/tmp/lsblk.txt)" -ne 1 ]; then
    sudo mkdir -p /mnt/fedora
    sudo mount UUID=722c5ee8-b300-4b51-86de-9221ebabc617 /mnt/fedora
    sudo mount UUID=906ecda7-1224-4533-9c0b-a5c070d3e68b /mnt/fedora/root/boot
    # cd /mnt/fedora || exit
    sudo mount --rbind /mnt/fedora/home /mnt/fedora/root/home
    sudo mount -t proc none /mnt/fedora/root/proc
    sudo mount --rbind /dev /mnt/fedora/root/dev
    sudo mount --rbind /sys /mnt/fedora/root/sys
    sudo mount --rbind /run /mnt/fedora/root/run
    sudo mount UUID=1EF4-FD52 /mnt/fedora/root/boot/efi
  else
    echo already mounted
  fi
  echo 'export PS1="(fedora-chroot) $PS1"'
  sudo chroot /mnt/fedora/root /bin/su - "$(id -un)"
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
  sudo chroot /mnt/archlinux /bin/su - "$(id -un)"
  # /usr/bin/sudo -E CHROOT=/mnt/archlinux chroot /mnt/archlinux su - henninb
  # doas chroot /mnt/archlinux su - "$(id -un)" -c 'export CHROOT=/mnt/archlinux; pwd'
  # doas chroot /mnt/archlinux su - "$(id -un)" -c 'export CHROOT=/mnt/archlinux $CHROOT'
  # /usr/bin/sudo -E CHROOT=/mnt/archlinux chroot /mnt/archlinux su - "$(id -un)"
  # sudo chroot /mnt/archlinux /bin/su -l "$(id -un)" -c 'echo test'
else
  echo "chose the correct os."
fi

exit 0
