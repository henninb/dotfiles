echo i915 is the driver used for nvidia
sudo pkg install -y x11-drivers/xf86-video-intel
echo i915kms_load="YES" > /boot/loader.conf
