
## steps

Determine the bus/slot/function of the device that you want to pass through to the guest with pciconf -v -l

For example, to pass through a Atheros Gigabit Ethernet adapter:
alc0@pci0:2:0:0:        class=0x020000 card=0xe0001458 chip=0x10831969 rev=0xc0 hdr=0x00
    vendor     = 'Atheros Communications'
    device     = 'AR8151 v2.0 Gigabit Ethernet'
    class      = network
    subclass   = ethernet
The bus/slot/function is for this devices is 2/0/0 (from the end of 'alc0@pci0:2:0:0')

3. Once the desired PCI device is identified, it and any others must be masked from the host early in the boot process with a PCI passthrough devices entries or "pptdevs" in loader.conf

The PCI device at bus/slot/function 2/0/0 would be masked from the host with:

    pptdevs="2/0/0"
    pptdevs="2/0/0 1/2/6 4/9/0"
