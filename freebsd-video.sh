echo i915 is the driver used for intel graphics cards
sudo pkg install -y x11-drivers/xf86-video-intel
echo i915kms_load="YES" > /boot/loader.conf

echo nvidia-driver-460.67
echo sudo pkg install nvidia-driver-460.67 for nvidia card
sudo pkg install nvidia-driver-460.67
echo add to /etc/rc.conf
kldload_nvidia="nvidia-modeset nvidia"


sudo pkg install emulators/linux_base-c7

linux_enable="YES"
nvidia_enable="YES"
#kldload_nvidia="linux nvidia nvidia-modeset"
kld_list="linux nvidia nvidia-modeset"

$ pciconf -lv
vgapci0@pci0:1:0:0:	class=0x030000 rev=0xa1 hdr=0x00 vendor=0x10de device=0x1401 subvendor=0x1043 subdevice=0x8520
    vendor     = 'NVIDIA Corporation'
    device     = 'GM206 [GeForce GTX 960]'
    class      = display
    subclass   = VGA


