#!/bin/sh

fc-list | grep -i 'monofur for Powerline'
echo
fc-list | grep -i 'Symbola'
echo
fc-list | grep -i 'FiraCode Nerd Font'
echo
fc-list | grep -i 'Awesome'
echo

echo
echo -e "\uE0A0"
echo -e "\uE0B0"
echo -e "SKULL AND CROSSBONES (U+2620) \U02620"
echo calendar: 
echo nocloud:
echo cloud: 
echo lotempicon: 
echo midtempicon: 
echo hitempicon: 
echo git: 
echo lightning: ⚡

fc-list | grep -i "monof"|awk -F: '{print $2}' |sort|uniq

exit 0

# vim: set ft=sh:
