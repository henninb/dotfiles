#!/bin/sh

cat <<  'EOF' > "$HOME/tmp/40_custom"
#!/bin/sh
exec tail -n +3 "$0"

# this file name should be 40_custom
# sudo cp grub_40_custom /etc/grub.d/40_custom
# sudo update-grub
# validate /boot/grub/grub.cfg

menuentry "Arch Linux" {
  set root=(hd1,gpt1)
  linux /vmlinuz-linux root=/dev/sda3
  initrd /initramfs-linux.img
}

menuentry "FreeBSD" {
  set root=(hd1,gpt2)
  chainloader +1
}

menuentry "System Reboot" {
  echo "System Reboot"
  reboot
}

menuentry "System Shutdown" {
  echo "System Shutdown"
  halt
}
EOF

chmod a+x "$HOME/tmp/40_custom"
sudo mv -v "$HOME/tmp/40_custom"  /etc/grub.d/40_custom
sudo grub-mkconfig -o /boot/grub/grub.cfg

exit 0
