echo i915 is the driver used for intel graphics cards
sudo pkg install -y x11-drivers/xf86-video-intel
echo i915kms_load="YES" > /boot/loader.conf

echo nvidia-driver-460.67
echo sudo pkg install nvidia-driver-460.67 for nvidia card
sudo pkg install nvidia-driver-460.67
echo add to /etc/rc.conf
kldload_nvidia="nvidia-modeset nvidia"
