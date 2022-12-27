#!/bin/sh

mkdir -p chroot-jail
mkdir -p chroot-jail/bin chroot-jail/lib64
cp $(which ls) chroot-jail/bin/
cp $(which bash) chroot-jail/bin/
# ldd $(which bash)
# ldd $(which ls)
# cp /lib/x86_64-linux-gnu/libtinfo.so.6 chroot-jail/lib/x86_64-linux-gnu/
# cp /lib/x86_64-linux-gnu/libdl.so.2 chroot-jail/lib/x86_64-linux-gnu/
# cp /lib/x86_64-linux-gnu/libc.so.6 chroot-jail/lib/x86_64-linux-gnu/
# cp /lib64/ld-linux-x86-64.so.2 chroot-jail/lib64/
cp /lib64/libreadline.so.8 chroot-jail/lib64/
cp /lib64/libtinfo.so.6 chroot-jail/lib64/
cp /lib64/libc.so.6 chroot-jail/lib64/
cp /lib64/libtinfow.so.6 chroot-jail/lib64/
cp /lib64/ld-linux-x86-64.so.2 chroot-jail/lib64/
echo sudo chroot chroot-jail

exit 0
