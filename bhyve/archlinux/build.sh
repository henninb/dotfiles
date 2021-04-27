#!/bin/sh

VMNAME=archlinux
TEMPLATE=archlinux

sudo killall cu
sudo vm stop $VMNAME
sudo vm destroy $VMNAME
ps -aux | grep grub-bhyve | grep -v grep
ps -aux | grep grub-bhyve | grep -v grep | awk '{print $2}' | xargs sudo kill -9
ps -aux | grep vm | grep -v "[vmdaemon]" | grep -v grep
sudo rm -rf /vm/$VMNAME
sudo mkdir -p /vm/.templates
sudo cp -v archlinux.conf /vm/.templates/
sudo mkdir -p /vm/.iso
sudo cp $TEMPLATE.conf /vm/.templates

echo create a switch
sudo vm switch list
echo sudo vm switch create public

echo add a network interface to the switch
echo sudo vm switch add public alc0

# echo sudo vm destroy $VMNAME
echo sudo vm iso 'https://mirrors.acm.wpi.edu/archlinux/iso/2021.04.01/archlinux-2021.04.01-x86_64.iso'
sudo vm iso
sudo vm create -t $TEMPLATE -s 50G $VMNAME
sudo vm install $VMNAME archlinux-2021.04.01-x86_64.iso
sudo vm start $VMNAME
sudo vm list
echo sudo vm console $VMNAME

exit 0
