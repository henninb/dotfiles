#!/bin/sh

sudo lpadmin -p HP_Photosmart_Prem_C310_series -E -v socket://192.168.20.35:9100 -P printer.conf

exit 0

# vim: set ft=sh:
