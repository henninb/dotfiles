#!/bin/sh

cat > devfs.rules <<EOF
[localrules=10]
        add path 'ugen*' mode 0660 group operator
        add path 'usb/*'  mode 0660 group operator
        add path 'usb' mode 0770 group operator
        add path 'cuaU*' mode 0770 group operator
EOF

echo 'devfs_system_ruleset="localrules"' | sudo tee -a /etc/rc.conf
cat devfs.rules

sudo pkg install xtensa-esp32-elf
sudo pkg install -y avr-binutils
sudo pkg install -y avr-gcc
sudo pkg install -y avr-libc
sudo pkg install -y avrdude
sudo pkg install devel/avrdude
cp /usr/local/bin/avrdude ~/.platformio/packages/tool-avrdude/avrdude_bin

echo "set platform = atmelavr@<1.12.0 in the project platformio.ini"

cd "$HOME/projects" || exit

echo run platformio from /compat/ubuntu/
echo access to cuaU* is required
echo inside: sudo ln -sfn /dev/cuaU0 /dev/ttyUSB0
echo groupadd -g 68 arduino
echo usermod -a -G arduino henninb

#git clone https://github.com/trombik/freebsd-ports-xtensa-lx106-elf.git
#cd - || exit

##git clone https://github.com/trombik/platformio-freebsd-toolchain-xtensa.git

#cd ~/.platformio/packages || exit
#git clone https://github.com/trombik/platformio-freebsd-toolchain-atmelavr.git toolchain-atmelavr
#cd ~/.platformio/packages/toolchain-atmelavr || exit
#./init.sh
#cd - || exit

exit 0
