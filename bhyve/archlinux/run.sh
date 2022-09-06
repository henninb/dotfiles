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
# sudo cp -v archlinux.conf /vm/.templates/
sudo mkdir -p /vm/.iso
sudo cp -v $TEMPLATE.conf /vm/.templates

echo sudo vm switch create public
sudo vm switch list
sudo vm switch add public re0
sudo vm switch create public em0

# echo sudo vm destroy $VMNAME
if [ -f "/vm/.templates/archlinux-2022.08.05-x86_64.iso" ]; then
  sudo vm iso '/vm/.templates/archlinux-2022.08.05-x86_64.iso'
else
  sudo vm iso 'https://mirror.arizona.edu/archlinux/iso/2022.08.05/archlinux-2022.08.05-x86_64.iso'
fi
sudo vm create -t $TEMPLATE -s 20G $VMNAME
sudo vm install -f $VMNAME archlinux-2022.08.05-x86_64.iso
echo sudo vm start $VMNAME
sudo vm list
echo sudo vm console $VMNAME
echo sudo killall cu

exit 0
