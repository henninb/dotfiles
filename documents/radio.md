# radio

git@github.com:rxseger/rx_tools.git

lsusb

The last line was the Realtek dongle:
Bus 001 Device 008: ID 0bda:2838 Realtek Semiconductor Corp.

The important parts are "0bda" (the vendor id) and "2838" (the product id).

Create a new file as root named /etc/udev/rules.d/20.rtlsdr.rules that contains the following line:

SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", GROUP="adm", MODE="0666", SYMLINK+="rtl_sdr"

With the vendor and product ids for your particular dongle. This should make the dongle accessible to any user in the adm group. and add a /dev/rtl_sdr symlink when the dongle is attached.

It's probably a good idea to unplug the dongle, restart udev (sudo restart udev) and re-plug in the dongle at this point.

# station
107900.000
92500.000
102100.000
