#!/usr/bin/env sh

cat > "$HOME/tmp/80-libvirt.rules" <<EOF
polkit.addRule(function(action, subject) {
 if (action.id == "org.libvirt.unix.manage" && subject.local && subject.active && subject.isInGroup("libvirt")) {
 return polkit.Result.YES;
 }
});
EOF

cat > "$HOME/tmp/libvirtd.conf" <<EOF
auth_unix_ro = "none"
auth_unix_rw = "none"
unix_sock_group = "wheel"
unix_sock_ro_perms = "0777"
unix_sock_rw_perms = "0770"
EOF

sudo mkdir -p /var/kvm/images
if [ "$(grep -c wheel /etc/group)" -ne 1 ]; then
  sudo chown root:wheel /var/kvm/images
else
  sudo chown root /var/kvm/images
fi

if [ "$OS" = "Linux Mint" ] || [  "$OS" = "Ubuntu" ]; then
  sudo apt install -y cpu-checker
  kvm-ok
  sudo apt install -y ebtables dnsmasq spice-client-gtk virt-viewer gir1.2-spiceclientgtk-3.0 libguestfs-tools
  # may need a reboot
  sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
  sudo adduser "$(id -un)" kvm
  sudo adduser "$(id -un)" libvirt
  sudo apt install -y virt-manager
  sudo apt install -y qemu-utils
  virsh -c qemu:///system list
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y libvirt
  sudo xbps-install -y qemu
  sudo xbps-install -y virt-manager
  sudo xbps-install -y virt-viewer
  sudo xbps-install -y virt-install
  sudo usermod -a -G libvirt "$(id -un)"
  sudo ln -s /etc/sv/libvirtd /var/service/libvirtd
  sudo sv start libvirtd
  virsh -c qemu:///system list
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y qemu-kvm
  sudo zypper install -y libvirt-daemon-system
  sudo zypper install -y libvirt-clients
  sudo zypper install -y libvirt
  sudo zypper install -y bridge-utils
  sudo zypper install -y ebtables
  sudo zypper install -y dnsmasq
  sudo zypper install -y spice-client-gtk
  sudo zypper install -y virt-viewer
  sudo zypper install -y virt-manager
  sudo zypper install -y gir1.2-spiceclientgtk-3.0
  sudo zypper install -y libguestfs-tools
  sudo usermod -a -G libvirt "$(id -un)"
  sudo usermod -a -G kvm "$(id -un)"
  # sudo systemctl start libvirtd
  sudo systemctl enable libvirtd --now
  virsh net-autostart default

  virsh pool-define /dev/stdin <<EOF
<pool type='dir'>
  <name>default</name>
  <target>
    <path>/var/lib/libvirt/images</path>
  </target>
</pool>
EOF

  virsh pool-start default
  virsh pool-autostart default
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  #sudo pacman -Syu libvirt qemu virt-manager spice-client-gtk virt-viewer gir1.2-spiceclientgtk-3.0
  sudo pacman --noconfirm --needed -S dmidecode
  sudo pacman --noconfirm --needed -S libvirt
  sudo pacman --noconfirm --needed -S qemu
  sudo pacman --noconfirm --needed -S virt-manager
  sudo pacman --noconfirm --needed -S virt-install
  sudo pacman --noconfirm --needed -S virt-viewer
  sudo pacman --noconfirm --needed -S dnsmasq
  sudo pacman --noconfirm --needed -S ebtables iptables dnsmasq
  sudo pacman --noconfirm --needed -S ebtables
  sudo pacman --noconfirm --needed -S edk2-ovmf
  #sudo pacman --noconfirm --needed -S firewalld
  sudo pacman --noconfirm --needed -S cdrtools
  sudo pacman --noconfirm --needed -S iptables

  # sudo pacman -Qi ebtables iptables dnsmasq

  sudo systemctl start libvirtd
  sudo systemctl enable libvirtd --now
  sudo systemctl enable iptables --now
  sudo systemctl status libvirtd
  sudo systemctl status iptables

  sudo usermod -a -G libvirt "$(id -un)"
  sudo usermod -a -G kvm "$(id -un)"

  virsh list --all
  virsh net-autostart default
  virsh net-list --all
  getent group kvm libvirt qemu
  echo "reboot system to fix virt network"
elif [ "$OS" = "Solus" ]; then
  echo
  sudo eopkg install -y libvirt
  # sudo eopkg install -y virt-manager
  sudo usermod -a -G libvirt "$(id -un)"
  sudo usermod -a -G kvm "$(id -un)"
  sudo usermod -a -G qemu "$(id -un)"
  sudo systemctl enable libvirtd --now
  # sudo systemctl start libvirtd
  virsh list --all
  virsh net-autostart default
  virsh net-list --all
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse bridge-utils
  sudo emerge --update --newuse app-emulation/libvirt
  sudo emerge --update --newuse libvirt
  sudo emerge --update --newuse libvirt-glib
  sudo emerge --update --newuse libvirt-python
  sudo emerge --update --newuse app-emulation/virt-viewer
  sudo emerge --update --newuse net-misc/spice-gtk
  sudo emerge --update --newuse virt-manager
  sudo emerge --update --newuse sys-firmware/edk2-ovmf ## uefi support
  sudo mv -v "$HOME/tmp/libvirtd.conf" /etc/libvirt/libvirtd.conf
  # sudo rc-update add libvirtd default
  # sudo rc-service libvirtd start
  sudo systemctl enable libvirtd --now
  # sudo systemctl start libvirtd
  sudo usermod -a -G libvirt "$(id -un)"
  sudo usermod -a -G kvm "$(id -un)"
  sudo usermod -a -G qemu "$(id -un)"
  echo grep KVM /usr/src/linux/.config
  lsmod | grep kvm
elif [ "$OS" = "Fedora Linux" ]; then
  #sudo dnf remove -y seabios-bin
  sudo dnf install -y seabios-bin
  sudo dnf install -y virt-install
  sudo dnf install -y virt-viewer
  sudo dnf install -y libvirt
  sudo dnf install -y edk2-ovmf
  sudo dnf install -y qemu
  sudo dnf install -y virt-manager
  sudo usermod -a -G libvirt "$(id -un)"
  sudo usermod -a -G kvm "$(id -un)"
  sudo usermod -a -G qemu "$(id -un)"
  # sudo systemctl start libvirtd
  sudo systemctl enable libvirtd --now
  virsh list --all
  virsh net-autostart default
  virsh net-list --all
elif [ "$OS" = "CentOS Linux" ]; then
  #sudo yum remove -y seabios-bin
  sudo yum install -y seabios
  sudo yum install -y seabios-bin
  sudo yum install -y virt-install
  sudo yum install -y libvirt
  sudo yum install -y qemu
  sudo yum install -y virt-manager
  sudo usermod -a -G libvirt "$(id -un)"
  sudo usermod -a -G kvm "$(id -un)"
  # sudo systemctl start libvirtd
  sudo systemctl enable libvirtd --now
  virsh list --all
  virsh net-autostart default
  virsh net-list --all
else
  echo "OS=$OS not setup yet."
  exit 1
fi

if [ -f "/etc/sysctl.conf" ]; then
  grep net.ipv4.ip_forward /etc/sysctl.conf
else
  echo sysctl.conf is not found
fi

echo sudo mv -v "$HOME/tmp/80-libvirt.rules" /etc/polkit-1/rules.d/80-libvirt.rules
echo virsh -c test:///default list --all
echo virsh -c qemu:///system list --all

exit 0

# vim: set ft=sh:
