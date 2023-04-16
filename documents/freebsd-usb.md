
vim /boot/loader.conf
pptdevs="0/26/0"

❯ pciconf -v -l | grep -B4 'subclass   = USB'

xhci0@pci0:0:20:0:	class=0x0c0330 rev=0x05 hdr=0x00 vendor=0x8086 device=0x8c31 subvendor=0x1458 subdevice=0x5007
    vendor     = 'Intel Corporation'
    device     = '8 Series/C220 Series Chipset Family USB xHCI'
    class      = serial bus
    subclass   = USB
--
ehci0@pci0:0:26:0:	class=0x0c0320 rev=0x05 hdr=0x00 vendor=0x8086 device=0x8c2d subvendor=0x1458 subdevice=0x5006
    vendor     = 'Intel Corporation'
    device     = '8 Series/C220 Series Chipset Family USB EHCI'
    class      = serial bus
    subclass   = USB
--
ehci1@pci0:0:29:0:	class=0x0c0320 rev=0x05 hdr=0x00 vendor=0x8086 device=0x8c26 subvendor=0x1458 subdevice=0x5006
    vendor     = 'Intel Corporation'
    device     = '8 Series/C220 Series Chipset Family USB EHCI'
    class      = serial bus
    subclass   = USB

❯ pciconf -lv | grep -B2 USB
xhci0@pci0:0:20:0:	class=0x0c0330 rev=0x05 hdr=0x00 vendor=0x8086 device=0x8c31 subvendor=0x1458 subdevice=0x5007
    vendor     = 'Intel Corporation'
    device     = '8 Series/C220 Series Chipset Family USB xHCI'
    class      = serial bus
    subclass   = USB
--
ehci0@pci0:0:26:0:	class=0x0c0320 rev=0x05 hdr=0x00 vendor=0x8086 device=0x8c2d subvendor=0x1458 subdevice=0x5006
    vendor     = 'Intel Corporation'
    device     = '8 Series/C220 Series Chipset Family USB EHCI'
    class      = serial bus
    subclass   = USB
--
ehci1@pci0:0:29:0:	class=0x0c0320 rev=0x05 hdr=0x00 vendor=0x8086 device=0x8c26 subvendor=0x1458 subdevice=0x5006
    vendor     = 'Intel Corporation'
    device     = '8 Series/C220 Series Chipset Family USB EHCI'
    class      = serial bus
    subclass   = USB

pciconf -lv | grep -A4 ^ppt
