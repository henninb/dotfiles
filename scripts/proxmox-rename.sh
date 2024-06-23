#!/bin/sh

echo "Put the VMID to change"
read oldVMID
case $oldVMID in
    ''|*[!0-9]*)
        echo "bad input. Exiting"
        exit 1
        ;;
    *)
        echo "Old VMID - $oldVMID"
        ;;
esac
echo

echo "Put the new VMID"
read newVMID
case $newVMID in
    ''|*[!0-9]*)
        echo "bad input. Exiting"
        exit 1
        ;;
    *)
        echo "New VMID - $newVMID"
        ;;
esac
echo

echo "$newVMID"
echo "$oldVMID"

# Check if volume group exists
VOLUME_GROUP="pve"
if ! vgdisplay "$VOLUME_GROUP" >/dev/null 2>&1; then
    echo "Volume group '$VOLUME_GROUP' not found. Exiting."
    exit 1
fi

if lvrename $VOLUME_GROUP/vm-"$oldVMID"-disk-0 vm-"$newVMID"-disk-0; then
    echo "Logical volume renamed successfully."
else
    echo "lvrename command failed. Exiting."
    exit 1
fi

sed -i "s/$oldVMID/$newVMID/g" /etc/pve/qemu-server/"$oldVMID".conf

mv /etc/pve/qemu-server/"$oldVMID".conf /etc/pve/qemu-server/"$newVMID".conf

exit 0
