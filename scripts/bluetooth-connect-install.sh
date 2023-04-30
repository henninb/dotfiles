#!/bin/sh

cat > bluetooth-connect.service <<EOF
[Unit]
Description=Bluetooth Connect Service

[Service]
ExecStart=/usr/local/bin/bluetooth-connect.sh

[Install]
WantedBy=multi-user.target
EOF


sudo cp bluetooth-connect.service /etc/systemd/system
sudo cp bluetooth-connect.sh /usr/local/bin
sudo cp bluetooth.txt /opt
doas systemctl enable bluetooth-connect.service

exit 0

# vim: set ft=sh:
