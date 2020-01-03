#!/bin/sh

#vmrun -T player start "/home/henninb/Downloads/64bit/Other Linux 4.x or later kernel 64-bit/Other Linux 4.x or later kernel 64-bit.vmx" nogui
vmrun -T player start "/home/henninb/Downloads/64bit/Other Linux 4.x or later kernel 64-bit/Other Linux 4.x or later kernel 64-bit.vmx" nogui
echo $?
vmrun -T player list

exit 0
