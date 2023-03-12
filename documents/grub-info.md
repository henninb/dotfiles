# grub info

## fix for screen resolution in the console on nvidia systems in linux mint
```
$ sudo vi /etc/default/grub

# grub changes for Nvidia with respect to screen resolution
# run the following after the updates to this file
# sudo update-grub
GRUB_GFXMODE=1920x1080x24
# Hack to force higher framebuffer resolution
GRUB_GFXPAYLOAD_LINUX=1920x1080
```

## grub visual tool
sudo apt install grub-customizer

## fix for proxmox
```
$ sudo vi /etc/default/grub
GRUB_CMDLINE_LINUX="intel_iommu=on"
$ sudo update-grub
$ sudo reboot
```

## manual boot
grub> ls

(hd0) (hd0,msdos2) (hd0,msdos1)

grub> root=(hd0,msdos1)

Now we can tell it to load or kernel image. (Just note that you must put in the full filename of the image.
grub> linux /vmlinuz root=/dev/sda2

tell the kernel where it can find it's initialization RAM disk (initrd)
grub> initrd /initrd.img
grub> boot



root=hd0,1
linux /boot/kernel-3.2.12-gentoo root=/dev/sda3
}

lsblk -f
├─sda1 ext2     1.0                          93854486-ecb9-4f51-82ea-16363d4c921e
└─sda2 ext4     1.0                          947dd6e2-9d62-42c3-bc4c-57415b8c6403
menuentry "Debian GNU/Linux, linux 2.6.26-2-xen-686" {
    set root=(hd0,1)
    search --fs-uuid --set 3765189f-fdaf-48d4-a04b-d696e6cffdbd
    linux    /boot/vmlinuz-2.6.26-2-xen-686 root=UUID=3765189f-fdaf-48d4-a04b-d696e6cffdbd ro console=ttyS0,115200 console=tty1 vga=792
    initrd    /boot/initrd.img-2.6.26-2-xen-686
}


## grub updates
```
sudo grub-mkconfig -o /boot/efi/EFI/gentoo/grub.cfg
sudo grub-mkconfig -o /boot/efi/EFI/mintlinux/grub.cfg
sudo grub-mkconfig -o /boot/efi/EFI/archlinux/grub.cfg
sudo grub-mkconfig -o /boot/efi/EFI/voidlinux/grub.cfg
sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg

sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo grubby --default-kernel
sudo grubby --info=ALL
sudo grub2-set-default 1
remove old boot entries /boot/loader/entries
```

## grub show text on boot - fedora
```
sudo grubby --remove-args='rhgb quiet' --update-kernel=ALL
systemctl get-default
runlevel
cat /proc/cmdline
sudo systemctl set-default multi-user.target
cd /etc/default
edit grub
GRUB_CMDLINE_LINUX="text"
GRUB_CMDLINE_LINUX="text rd.plymouth=0 plymouth.enable=0"
GRUB_CMDLINE_LINUX="text modprobe.blacklist=nouveau nvidia-drm.modeset=1 rd.plymouth=0 plymouth.enable=0"
GRUB_TERMINAL_OUTPUT="console"
GRUB_GFXPAYLOAD_LINUX="text"

sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
```


## grub install uefi
sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub

## multiple OS auto update
 /etc/default/grub
GRUB_DISABLE_OS_PROBER=false
pacman -S os-prober


## validate efi
efibootmgr -v


## validate fs
grub-probe --target=fs --device /dev/nvme0n1p1

## loglevel
loglevel= All Kernel Messages with a loglevel smaller than the
console loglevel will be printed to the console. It can
also be changed with klogd or other programs. The
loglevels are defined as follows:

                    0 (KERN_EMERG)          system is unusable
                    1 (KERN_ALERT)          action must be taken immediately
                    2 (KERN_CRIT)           critical conditions
                    3 (KERN_ERR)            error conditions
                    4 (KERN_WARNING)        warning conditions
                    5 (KERN_NOTICE)         normal but significant condition
                    6 (KERN_INFO)           informational
                    7 (KERN_DEBUG)          debug-level messages


## tune2fs does not work on fat partitions
tune2fs -l /dev/nvme0n1p1 | grep metadata_csum_seed
tune2fs: Bad magic number in super-block while trying to open /dev/nvme0n1p1
