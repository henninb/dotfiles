#!/bin/sh

if command -v emerge; then
    sudo emerge --update --newuse net-misc/x2goclient
fi 

exit 0
