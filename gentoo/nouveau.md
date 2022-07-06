nouveau
KERNEL Enabling nouveau
Device Drivers  --->
   Graphics support  --->
      <*> Direct Rendering Manager (XFree86 4.1.0 and higher DRI support) --->
         <*> Enable legacy fbdev support for your modesetting driver
      <M/*> Nouveau (NVIDIA) cards
Firmware
Beginning with the Kepler series (GeForce 600 and above), some cards may need to load firmware at boot time in order to operate correctly. It is recommended to build firmware that is needed into the kernel. This is the default for systems running the systemd init system. See the Linux firmware article for more information on building firmware into the kernel.

See upstream's list of codenames to determine what firmware is necessary.

Firmware for nouveau cards are distributed in the sys-firmware/nvidia-firmware package. Be sure it has been installed before defining firmware in the kernel:

root #emerge --ask sys-firmware/nvidia-firmware
Driver
Portage uses the USE_EXPAND variable called VIDEO_CARDS to enable support for various graphics cards in packages. Setting VIDEO_CARDS to appropriate value(s) will pull in the correct driver(s):

FILE /etc/portage/make.conf
Set VIDEO_CARDS to nouveau
VIDEO_CARDS="nouveau"
