#!/bin/sh

cat > locale.gen << EOF
en_US.UTF-8 UTF-8
EOF

sudo mv -v locale.gen /etc/locale.gen¬
sudo locale-gen
echo sudo eselect locale set 4
sudo eselect locale list

sudo xbps-reconfigure -f glibc-locales
sudo xbps-reconfigure -f glibc-locales
locale -a

exit 0


!!! Error: Action 4 unknown
exiting
Setting LANG to en_US.utf8 ...
Run ". /etc/profile" to update the variable in your shell.
