#!/bin/sh
#
# This script downloads the FreeBSD 14.2 amd64 DVD1 ISO and
# launches it with virt-install under KVM.
#
# Usage: ./freebsd14.2.sh [remove y/n]
# If "y" is passed, the script only cleans up existing VM and disk.

# --- Argument check ---
if [ $# -gt 1 ]; then
  echo "Usage: $0 [remove y/n]" >&2
  exit 1
fi
remove=$1

# --- Dependencies ---
missing=0
for dep in virsh virt-install wget grep sed sudo; do
  if ! command -v $dep >/dev/null 2>&1; then
    echo "Error: '$dep' is not installed." >&2
    missing=1
  fi
done
[ $missing -ne 0 ] && exit 1

# --- Ensure sudo (if not root) ---
if [ "$(id -u)" -ne 0 ] && ! sudo -n true 2>/dev/null; then
  echo "Error: sudo without password required. Run as root or adjust sudoers." >&2
  exit 1
fi

# --- Variables ---
guest_name="freebsd"
boot_dir="/var/lib/libvirt/boot"
images_dir="/var/lib/libvirt/images"
base_url="https://download.freebsd.org/releases/amd64/amd64/ISO-IMAGES/14.2"
iso_pattern='FreeBSD-14\.2-RELEASE-amd64-dvd1\.iso'

# --- Teardown old VM ---
virsh shutdown guest-$guest_name 2>/dev/null
virsh destroy  guest-$guest_name 2>/dev/null
virsh undefine guest-$guest_name 2>/dev/null

# --- Prepare dirs ---
sudo mkdir -p "$boot_dir" "$images_dir"
sudo chown -R qemu:qemu "$boot_dir" "$images_dir"

# --- Remove old disk if present ---
if [ -f "$images_dir/guest-$guest_name.qcow2" ]; then
  sudo rm "$images_dir/guest-$guest_name.qcow2"
fi

[ "$remove" = "y" ] && { echo "Cleanup only; exiting."; exit 0; }

# --- Fetch ISO name ---
iso_file=$(wget -qO - "$base_url/" \
           | grep -oE "$iso_pattern" \
           | head -1)

[ -z "$iso_file" ] && {
  echo "Error: could not find ISO in $base_url" >&2
  exit 1
}

# --- Download ISO if needed ---
if [ ! -f "$boot_dir/$iso_file" ]; then
  echo "Downloading $iso_file..."
  sudo wget -O "$boot_dir/$iso_file" "$base_url/$iso_file" \
    || { echo "Download failed." >&2; exit 1; }
fi

# --- Info hints ---
echo "List OS variants with: osinfo-query os"
echo "Disk bus: virtio (vda) or sata (sda)."

# --- Optional: set up macvtap0 ---
echo "sudo ip link add link enp3s0 name macvtap0 type macvtap mode private"
sudo ip link add link enp3s0 name macvtap0 type macvtap mode private
echo "ip addr show macvtap0"

# --- Launch VM ---
exec sudo virt-install \
  --connect qemu:///system \
  --virt-type=kvm \
  --name "guest-$guest_name" \
  --os-variant=freebsd14.2 \
  --memory=4096,maxmemory=4096 \
  --vcpus=2,maxvcpus=4 \
  --hvm \
  --boot uefi \
  --cdrom="$boot_dir/$iso_file" \
  --network type=direct,source=macvtap0,source_mode=bridge,model=virtio \
  --graphics vnc \
  --disk path="$images_dir/guest-$guest_name.qcow2",size=50,bus=sata,format=qcow2

exit 0

#!/bin/sh
#
# This script downloads the latest FreeBSD amd64 DVD ISO from the official
# FreeBSD mirror and uses virt-install to launch it with KVM.
#
# Usage: ./freebsd_script.sh [remove y/n]
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

[ $missing -ne 0 ] && exit 1

# --- Check sudo permissions if not running as root ---
if [ "$(id -u)" -ne 0 ]; then
    if ! sudo -n true 2>/dev/null; then
        echo "Error: This script requires sudo privileges for some operations.
Please run as root or configure sudo to allow passwordless execution." >&2
        exit 1
    fi
fi

# --- Variables ---
guest_name="freebsd"
boot_dir="/var/lib/libvirt/boot"
images_dir="/var/lib/libvirt/images"
# Point to the latest FreeBSD ISO listings
base_url="https://download.freebsd.org/ftp/releases/ISO-IMAGES"
# Match the latest RELEASE-amd64-dvd1 ISO
iso_pattern='FreeBSD-[0-9]+\.[0-9]+-RELEASE-amd64-dvd1\.iso'

# --- Cleanup Existing VM ---
virsh shutdown "guest-$guest_name" 2>/dev/null
virsh destroy  "guest-$guest_name" 2>/dev/null
virsh undefine "guest-$guest_name" 2>/dev/null

# --- Prepare Directories ---
sudo mkdir -p "$boot_dir" "$images_dir" || {
    echo "Error: Unable to create $boot_dir or $images_dir" >&2
    exit 1
}
sudo chown -R qemu:qemu "$boot_dir" "$images_dir"

# Remove any existing disk image
if [ -f "$images_dir/guest-$guest_name.qcow2" ]; then
    sudo rm "$images_dir/guest-$guest_name.qcow2" || {
        echo "Error: Failed to remove existing disk image." >&2
        exit 1
    }
fi

[ "$remove" = "y" ] && { echo "Cleanup only; exiting."; exit 0; }

# --- Download the Latest FreeBSD ISO ---
# Fetch the directory listing, extract the ISO name, grab the first match
iso_file=$(wget -qO - "$base_url" | \
           grep -oE "$iso_pattern" | \
           head -n1)

[ -z "$iso_file" ] && {
    echo "Error: Could not locate FreeBSD ISO in $base_url" >&2
    exit 1
}

# Download ISO if not already present
if [ ! -f "$boot_dir/$iso_file" ]; then
    echo "Downloading $iso_file..."
    sudo wget -O "$boot_dir/$iso_file" "$base_url/$iso_file" || {
        echo "Error: Download failed." >&2
        exit 1
    }
fi

echo "Run 'osinfo-query os' to list supported --os-variant values."
echo "Disk bus can be virtio (vda) or sata (sda)."

# --- Setup macvtap interface (if desired) ---
echo 'sudo ip link add link enp3s0 name macvtap0 type macvtap mode private'
echo 'ip addr show macvtap0'

# --- Launch the VM ---
exec sudo virt-install \
  --connect qemu:///system \
  --virt-type=kvm \
  --name "guest-$guest_name" \
  --os-variant=freebsd14.0 \
  --memory=4096,maxmemory=4096 \
  --vcpus=2,maxvcpus=4 \
  --hvm \
  --boot uefi \
  --cdrom="$boot_dir/$iso_file" \
  --network type=direct,source=macvtap0,source_mode=bridge,model=virtio \
  --graphics vnc \
  --disk path="$images_dir/guest-$guest_name.qcow2",size=50,bus=sata,format=qcow2

exit 0
