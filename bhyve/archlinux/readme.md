## grub
set root=(hd0,msdos1)
linux /vmlinuz-linux root=UUID=2602b99f-6b11-4138-8543-3e72066b88b1 rw
initrd /initramfs-linux.img
boot
