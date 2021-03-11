sudo pacman -S avr-gcc
sudo pacman -S avrdude


avrdude -p m328p -c usbasp -v


sudo cp /etc/udev/rules.d 
sudo cp 99-USBasp.rules /etc/udev/rules.d/

sudo udevadm control --reload-rules && udevadm trigger
