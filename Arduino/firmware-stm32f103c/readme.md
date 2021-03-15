[10810.111664] cdc_acm 3-1:1.0: failed to set dtr/rts


https://www.youtube.com/watch?v=J66_8P043ko

sudo pacman -S dfu-util

Some additional udev rules are needed to ensure that the maple 1eaf devices are correctly enumerated.

See your Linux documentation for details. The rules below will work for most Linux versions.

ATTRS{idProduct}=="1001", ATTRS{idVendor}=="0110", MODE="664", GROUP="plugdev"
ATTRS{idProduct}=="1002", ATTRS{idVendor}=="0110", MODE="664", GROUP="plugdev"
ATTRS{idProduct}=="0003", ATTRS{idVendor}=="1eaf", MODE="664", GROUP="plugdev" SYMLINK+="maple"
ATTRS{idProduct}=="0004", ATTRS{idVendor}=="1eaf", MODE="664", GROUP="plugdev" SYMLINK+="maple"
Save the rules locally as 45-maple.rules then do something like...

sudo cp -v 45-maple.rules /etc/udev/rules.d/45-maple.rules
sudo chown root:root /etc/udev/rules.d/45-maple.rules
sudo chmod 644 /etc/udev/rules.d/45-maple.rules
sudo reboot
