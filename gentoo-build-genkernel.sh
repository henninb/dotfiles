#!/bin/sh

echo sudo emerge sys-kernel/gentoo-sources:5.18.10
eselect kernel list
echo eselect kernel set 2
echo genkernel all

exit 0
