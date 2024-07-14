#!/bin/sh

IP=192.168.4.92

doas cp $HOME/config/printers.conf /etc/cups/printers.conf
sudo systemctl restart cups

#sudo lpadmin -p HP_Photosmart_Prem_C310_series -E -v socket://192.168.4.92:9100 -P printers.conf

exit 0

# vim: set ft=sh:
