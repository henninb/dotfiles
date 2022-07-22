#!/bin/sh

OSK="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VMDIR="$PWD"
OVMF="$VMDIR/firmware"
#export QEMU_AUDIO_DRV=pa
#QEMU_AUDIO_DRV=pa

echo udisksctl mount -b /dev/sda1

if [ "$(uname -n)" = "silverfox" ]; then
  echo udisksctl mount -b /dev/sda1
  echo  "to exit the mac ctl+alt+g"
  qemu-system-x86_64 \
    -enable-kvm \
    -m 6G \
    -machine q35,accel=kvm \
    -smp 4,cores=2 \
    -cpu Penryn,vendor=GenuineIntel,kvm=on,+sse3,+sse4.2,+aes,+xsave,+avx,+xsaveopt,+xsavec,+xgetbv1,+avx2,+bmi2,+smep,+bmi1,+fma,+movbe,+invtsc \
    -device isa-applesmc,osk="$OSK" \
    -smbios type=2 \
    -drive if=pflash,format=raw,readonly,file="$OVMF/OVMF_CODE.fd" \
    -drive if=pflash,format=raw,file="$OVMF/OVMF_VARS-1024x768.fd" \
    -vga qxl \
    -device ich9-intel-hda -device hda-output \
    -usb -device usb-kbd -device usb-mouse \
    -netdev user,id=net0,hostfwd=tcp::2222-:22 \
    -device e1000-82545em,netdev=net0,id=net0,mac=52:54:00:c9:18:27 \
    -device ich9-ahci,id=sata \
    -drive id=ESP,if=none,format=qcow2,file=/media/henninb/Data/ESP.qcow2 \
    -device ide-hd,bus=sata.2,drive=ESP \
    -drive id=SystemDisk,if=none,file=/media/henninb/Data/macos-qemu-disk.qcow2 \
    -device ide-hd,bus=sata.4,drive=SystemDisk
#    -nogrphic -vnc :0 -k en-us \
#elif [ "$(uname -n)" = "archlinux" ]; then
elif [ "$(uname -n)" = "archlinux" ]; then
  echo udisksctl mount -b /dev/sda1
  echo  "to exit the mac ctl+alt+g"

  qemu-system-x86_64 \
    -enable-kvm \
    -m 6G \
    -machine q35,accel=kvm \
    -smp 4,cores=2 \
    -cpu Penryn,vendor=GenuineIntel,kvm=on,+sse3,+sse4.2,+aes,+xsave,+avx,+xsaveopt,+xsavec,+xgetbv1,+avx2,+bmi2,+smep,+bmi1,+fma,+movbe,+invtsc \
    -device isa-applesmc,osk="$OSK" \
    -smbios type=2 \
    -drive if=pflash,format=raw,readonly,file="$OVMF/OVMF_CODE.fd" \
    -drive if=pflash,format=raw,file="$OVMF/OVMF_VARS-1024x768.fd" \
    -vga qxl \
    -device ich9-intel-hda -device hda-output \
    -usb -device usb-kbd -device usb-mouse \
    -netdev user,id=net0,hostfwd=tcp::2222-:22 \
    -device e1000-82545em,netdev=net0,id=net0,mac=52:54:00:c9:18:27 \
    -device ich9-ahci,id=sata \
    -drive id=ESP,if=none,format=qcow2,file=/run/media/henninb/Data/ESP.qcow2 \
    -device ide-hd,bus=sata.2,drive=ESP \
    -drive id=SystemDisk,if=none,file=/run/media/henninb/Data/macos-qemu-disk.qcow2 \
    -device ide-hd,bus=sata.4,drive=SystemDisk
else
  echo "need to configure."
  exit 1
fi

exit 0
# needed for install only
# needed for install only
    # -drive id=InstallMedia,format=raw,if=none,file=BaseSystem.img
    # -device ide-hd,bus=sata.3,drive=InstallMedia

# vim: set ft=sh:
