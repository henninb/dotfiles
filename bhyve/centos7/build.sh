#!/bin/sh

sudo killall cu
sudo vm stop centos76
sudo vm destroy centos76
ps -aux | grep grub-bhyve | grep -v grep
ps -aux | grep grub-bhyve | grep -v grep | awk '{print $2}' | xargs sudo kill -9
ps -aux| grep vm | grep -v "[vmdaemon]" | grep -v grep
sudo rm -rf /vm/centos76
#sudo mkdir -p /vm/centos76
sudo mkdir -p /vm/.templates
sudo mkdir -p /vm/.iso
sudo cp centos76.conf /vm/.templates

echo create a switch
sudo vm switch list
echo sudo vm switch create public

echo add a network interface to the switch
echo sudo vm switch add public alc0

echo sudo vm destroy centos76
#sudo vm iso /vm/.iso/CentOS-7-x86_64-Minimal-1511.iso
sudo vm iso /vm/.iso/CentOS-7-x86_64-Minimal-1810.iso
sudo vm create -t centos76 -s 10G centos76
#sudo cp device.map /vm/centos76
sudo vm install centos76 CentOS-7-x86_64-Minimal-1810.iso
sudo vm start centos76
sudo vm list

exit 0
