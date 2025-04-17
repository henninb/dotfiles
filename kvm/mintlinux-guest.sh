#!/bin/sh
#
# This script downloads the latest Linux Mint Cinnamon 64-bit ISO from an
# official Linux Mint mirror and uses virt-install to launch it with KVM.
#
# Usage: ./mint_script.sh [remove y/n]
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
        echo "Error: Required command '$1' is not installed. Please install it." >&2
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
        echo "Error: This script requires sudo privileges for some operations.
Please run as root or configure sudo to allow passwordless execution." >&2
        exit 1
    fi
fi

# --- Variables ---
guest_name="mint"
boot_dir="/var/lib/libvirt/boot"
images_dir="/var/lib/libvirt/images"
# You may choose a different mirror if needed.
base_url="https://mirrors.edge.kernel.org/linuxmint/stable/22.1"
# If you want Cinnamon edition instead of XFCE, change the grep pattern accordingly.
# For example, if the Cinnamon ISO name is "linuxmint-22.1-cinnamon-64bit.iso", update below.
iso_pattern='href="linuxmint-22.1-xfce-64bit\.iso"'

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

# --- Download the Latest Linux Mint ISO ---
# Use grep to extract the ISO file name.
iso_file=$(wget -qO - "$base_url" | \
           grep -oE "$iso_pattern" | \
           head -n 1 | sed 's/href="//;s/"//')
if [ -z "$iso_file" ]; then
    echo "Error: Failed to locate the Linux Mint ISO file on $base_url" >&2
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
# Adjustments made:
#   - Using --os-variant to help set defaults.
#   - Changing the hard disk bus from scsi to sata.
#   - Making sure the CDROM uses the downloaded ISO file via $iso_file.
#
# Note: Once installation is complete, the ISO remains attached. You’ll want to remove
#       the installation media (via virt-manager or virsh edit) so that on reboot the disk boots.
echo 'sudo ip link add link enp3s0 name macvtap0 type macvtap mode private'
echo 'ip addr show macvtap0'

exec virt-install \
  --connect qemu:///system \
  --virt-type=kvm \
  --name "guest-$guest_name" \
  --os-variant=ubuntu22.04 \
  --memory=8192,maxmemory=8192 \
  --vcpus=1,maxvcpus=2 \
  --hvm \
  --boot uefi \
  --cdrom="$boot_dir/$iso_file" \
  --network type=direct,source=macvtap0,source_mode=bridge,model=virtio \
  --graphics vnc \
  --disk path="$images_dir/guest-$guest_name.qcow2",size=100,bus=sata,format=qcow2

exit 0
