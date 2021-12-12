#!/bin/sh

curl -sSL https://install.pi-hole.net | sudo bash

echo set password
pihole -a -p

exit 0
