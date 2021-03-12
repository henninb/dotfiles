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
avrdude -c usbasp -p m8 -B 1 -U flash:w:usbasp.atmega8.2011-05-28.hex

## programmer connected
avrdude -p m8 -c usbasp -v



