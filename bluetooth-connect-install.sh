#!/bin/sh

cat > bluetooth-connect-service <<EOF
[Unit]
Description=Bluetooth Connect Service

[Service]
ExecStart=/usr/local/bin/bluetooth-connect.sh

[Install]
WantedBy=multi-user.target
EOF
