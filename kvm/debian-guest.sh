#!/bin/sh
#
# This script downloads the latest Debian netinst ISO for AMD64 from the official
# Debian mirror and uses virt-install to launch it with KVM.
#
# Usage: ./script.sh [remove y/n]
# If "y" is passed, the script will only perform cleanup operations.
#

# --- Check for required command-line arguments ---
if [ $# -gt 1 ]; then
    echo "Usage: $0 [remove y/n]" >&2
    exit 1
fi
remove=$1

# --- Dependency Checks ---
missing=0
check_dep() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Error: Required command '$1' is not installed. Please install it (e.g. 'emerge libvirt' on Gentoo)." >&2
        missing=1
    fi
}

for dep in virsh virt-install wget grep sed sudo; do
    check_dep "$dep"
done

if [ $missing -ne 0 ]; then
    exit 1
fi

# --- Check sudo permissions if not running as root ---
if [ "$(id -u)" -ne 0 ]; then
    if ! sudo -n true 2>/dev/null; then
        echo "Error: This script requires sudo privileges for some operations. Please ensure your user is allowed to run sudo without a password prompt or run this script as root." >&2
        exit 1
    fi
fi

# --- Variables ---
guest_name="debian"
boot_dir="/var/lib/libvirt/boot"
images_dir="/var/lib/libvirt/images"
base_url="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd"

# --- Cleanup Existing VM ---
# Attempt to gracefully stop and undefine the guest VM.
virsh shutdown "guest-$guest_name" 2>/dev/null
virsh destroy "guest-$guest_name" 2>/dev/null
virsh undefine "guest-$guest_name" 2>/dev/null

# --- Prepare Directories ---
if ! sudo mkdir -p "$boot_dir"; then
    echo "Error: Unable to create directory $boot_dir" >&2
    exit 1
fi

if ! sudo mkdir -p "$images_dir"; then
    echo "Error: Unable to create directory $images_dir" >&2
    exit 1
fi

if ! sudo chown -R qemu:qemu "$boot_dir"; then
    echo "Error: Failed to set ownership for $boot_dir" >&2
    exit 1
fi

if ! sudo chown -R qemu:qemu "$images_dir"; then
    echo "Error: Failed to set ownership for $images_dir" >&2
    exit 1
fi

# Remove any existing disk image.
if [ -f "$images_dir/guest-$guest_name.qcow2" ]; then
    if ! sudo rm "$images_dir/guest-$guest_name.qcow2"; then
        echo "Error: Failed to remove the existing disk image." >&2
        exit 1
    fi
fi

if [ "$remove" = "y" ]; then
    echo "Remove-only option set; exiting after cleanup."
    exit 0
fi

# --- Download the Latest Debian ISO ---
# Parse the ISO file name from the Debian mirror directory listing.
iso_file=$(wget -qO - "$base_url/" | \
           grep -oE 'href="debian-[0-9\.]+-amd64-netinst\.iso"' | \
           head -n 1 | sed 's/href="//;s/"//')
if [ -z "$iso_file" ]; then
    echo "Error: Failed to locate the Debian ISO file on $base_url" >&2
    exit 1
fi

# If the ISO is not present, download it.
if [ ! -f "$boot_dir/$iso_file" ]; then
    echo "Downloading $iso_file from $base_url ..."
    if ! wget -O "$boot_dir/$iso_file" "$base_url/$iso_file"; then
        echo "Error: Failed to download $iso_file from $base_url" >&2
        exit 1
    fi
fi

echo "osinfo-query os"
echo "disk bus can be virtio (i.e. vda) or scsi (i.e. sda)"

# --- Launch the Virtual Machine ---
exec virt-install \
  --connect qemu:///system \
  --virt-type=kvm \
  --name "guest-$guest_name" \
  --memory=8192,maxmemory=8192 \
  --vcpus=1,maxvcpus=2 \
  --hvm \
  --boot uefi \
  --cdrom="$boot_dir/$iso_file" \
  --network=bridge=virbr0,model=virtio \
  --graphics vnc \
  --disk path="$images_dir/guest-$guest_name.qcow2",size=40,bus=scsi,format=qcow2

exit 0


#!/bin/sh
#
# This script downloads the latest Debian netinst ISO (for AMD64)
# from the official Debian mirror and then uses virt-install to run it
# in a new KVM virtual machine.
#
# Usage: ./script.sh [remove y/n]
# If "y" is passed, it will stop after cleanup (remove only).

if [ $# -gt 1 ]; then
    echo "Usage: $0 [remove y/n]"
    exit 1
fi

remove=$1
guest_name="debian"
boot_dir="/var/lib/libvirt/boot"
images_dir="/var/lib/libvirt/images"
base_url="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd"

# Attempt to gracefully stop the guest, if it exists.
virsh shutdown "guest-$guest_name" 2>/dev/null
virsh destroy "guest-$guest_name" 2>/dev/null
virsh undefine "guest-$guest_name" 2>/dev/null

# Ensure boot and images directories exist and are owned by qemu.
sudo mkdir -p "$boot_dir"
sudo mkdir -p "$images_dir"
sudo chown -R qemu:qemu "$boot_dir"
sudo chown -R qemu:qemu "$images_dir"

# Remove any old disk image.
if [ -f "$images_dir/guest-$guest_name.qcow2" ]; then
    sudo rm "$images_dir/guest-$guest_name.qcow2"
fi

if [ "$remove" = "y" ]; then
    echo "Remove only; exiting after cleanup."
    exit 0
fi

# Dynamically determine the latest Debian netinst ISO file name.
iso_file=$(wget -qO - "$base_url/" | \
           grep -oE 'href="debian-[0-9\.]+-amd64-netinst\.iso"' | \
           head -n 1 | sed 's/href="//;s/"//')
if [ -z "$iso_file" ]; then
    echo "Failed to locate Debian ISO file on $base_url"
    exit 1
fi

# Download the ISO if it is not already present.
if [ ! -f "$boot_dir/$iso_file" ]; then
    echo "Downloading $iso_file from $base_url ..."
    wget -O "$boot_dir/$iso_file" "$base_url/$iso_file" || exit 1
fi

echo "osinfo-query os"
echo "disk bus can be virtio (i.e. vda) or scsi (i.e. sda)"

exec virt-install \
  --connect qemu:///system \
  --virt-type=kvm \
  --name "guest-$guest_name" \
  --memory=8192,maxmemory=8192 \
  --vcpus=1,maxvcpus=2 \
  --hvm \
  --boot uefi \
  --cdrom="$boot_dir/$iso_file" \
  --network=bridge=virbr0,model=virtio \
  --graphics vnc \
  --disk path="$images_dir/guest-$guest_name.qcow2",size=40,bus=scsi,format=qcow2

exit 0


#!/bin/sh

if [ $# -gt 1 ]; then
    echo "Usage: $0 [remove y/n]"
    exit 1
fi

remove=$1
iso_file="debian-11.6.0-amd64-netinst.iso"
guest_name="debian"

virsh shutdown "guest-$guest_name"
virsh destroy "guest-$guest_name"
virsh undefine "guest-$guest_name"

sudo mkdir -p /var/lib/libvirt/boot
sudo mkdir -p /var/lib/libvirt/images
sudo chown -R qemu:qemu /var/lib/libvirt/boot
sudo chown -R qemu:qemu /var/lib/libvirt/images
sudo rm "/var/lib/libvirt/images/guest-${guest_name}.qcow2"

if [ "$remove" = "y" ]; then
  echo "remove only"
  exit 1
fi

if [ ! -f "/var/lib/libvirt/boot/${iso_file}" ]; then
  scp -p "pi:/home/pi/shared/template/iso/${iso_file}" .
  sudo mv "${iso_file}" /var/lib/libvirt/boot/
fi

echo "osinfo-query os"
echo "disk bus can be virtio i.e. vda, or scsi i.e. sda"

exec virt-install \
--connect qemu:///system \
--virt-type=kvm \
--name "guest-$guest_name" \
--memory=8192,maxmemory=8192 \
--vcpus=1,maxvcpus=2 \
--virt-type=kvm \
--hvm \
--boot uefi \
--cdrom=/var/lib/libvirt/boot/${iso_file} \
--network=bridge=virbr0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-$guest_name.qcow2,size=40,bus=scsi,format=qcow2

exit 0
