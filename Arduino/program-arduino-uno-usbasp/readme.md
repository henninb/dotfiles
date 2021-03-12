## install software
sudo pacman -S avr-gcc
sudo pacman -S avrdude


## arduino uno connected
avrdude -p m328p -c usbasp -v

## change access for usbasp on linux
sudo cp /etc/udev/rules.d 
sudo cp 99-USBasp.rules /etc/udev/rules.d/
reboot

## flash firmware of another programmer
avrdude -c usbasp -p m8 -U flash:w:usbasp.atmega48.2009-02-28.hex:i

## programmer connected
avrdude -p m8 -c usbasp -v

