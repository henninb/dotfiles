#!/bin/sh

VMNAME=ubuntu
TEMPLATE=ubuntu

sudo killall cu
sudo vm stop $VMNAME
sudo vm destroy $VMNAME
ps -aux | grep grub-bhyve | grep -v grep
ps -aux | grep grub-bhyve | grep -v grep | awk '{print $2}' | xargs sudo kill -9
ps -aux| grep vm | grep -v "[vmdaemon]" | grep -v grep
sudo rm -rf /vm/$VMNAME
sudo cp /usr/local/share/examples/vm-bhyve/* /vm/.templates/
sudo mkdir -p /vm/.templates
sudo mkdir -p /vm/.iso
sudo cp $TEMPLATE.conf /vm/.templates

echo create a switch
sudo vm switch list
echo sudo vm switch create public

echo add a network interface to the switch
echo sudo vm switch add public alc0

echo sudo vm destroy $VMNAME
echo load iso into memory
sudo vm iso /vm/.iso/ubuntu-18.04.1.0-live-server-amd64.iso
sudo vm create -t $TEMPLATE -s 10G $VMNAME
sudo vm install $VMNAME ubuntu-18.04.1.0-live-server-amd64.iso
sudo vm start $VMNAME
sudo vm list
echo sudo vm console $VMNAME

exit 0
