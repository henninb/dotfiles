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
  doas apt install -y cpu-checker
  doas apt install -y ebtables
  doas apt install -y dnsmasq
  doas apt install -y spice-client-gtk
  doas apt install -y virt-viewer
  doas apt install -y gir1.2-spiceclientgtk-3.0
  doas apt install -y libguestfs-tools
  doas apt install -y qemu-kvm
  doas apt install -y libvirt-daemon-system
  suod apt install -y libvirt-clients
  doas apt install -y bridge-utils
  doas apt install -y virt-manager
  doas apt install -y qemu-utils
  # sudo adduser "$(id -un)" kvm
  # sudo adduser "$(id -un)" libvirt
  doas usermod -a -G libvirt "$(id -un)"
  doas usermod -a -G kvm "$(id -un)"
  virsh -c qemu:///system list
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y libvirt
  doas xbps-install -y qemu
  doas xbps-install -y virt-manager
  doas xbps-install -y virt-viewer
  doas xbps-install -y virt-install
  doas xbps-install -y virtio-win

  doas usermod -a -G libvirt "$(id -un)"
  sudo ln -sfn /etc/sv/libvirtd /var/service/libvirtd
  # sudo ln -sfn /etc/sv/libvirtd /etc/runit/runsvdir/current/
  doas sv start libvirtd
  virsh -c qemu:///system list
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y qemu-kvm
  doas zypper install -y libvirt-daemon-system
  doas zypper install -y libvirt-clients
  doas zypper install -y libvirt
  doas zypper install -y bridge-utils
  doas zypper install -y ebtables
  doas zypper install -y dnsmasq
  doas zypper install -y spice-client-gtk
  doas zypper install -y virt-viewer
  doas zypper install -y virt-manager
  doas zypper install -y gir1.2-spiceclientgtk-3.0
  doas zypper install -y libguestfs-tools
  doas usermod -a -G libvirt "$(id -un)"
  doas usermod -a -G kvm "$(id -un)"
  # sudo systemctl start libvirtd
  doas systemctl enable libvirtd --now
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
  doas pacman --noconfirm --needed -S dmidecode
  doas pacman --noconfirm --needed -S libvirt
  doas pacman --noconfirm --needed -S qemu
  doas pacman --noconfirm --needed -S virt-manager
  doas pacman --noconfirm --needed -S virt-install
  doas pacman --noconfirm --needed -S virt-viewer
  doas pacman --noconfirm --needed -S dnsmasq
  doas pacman --noconfirm --needed -S ebtables iptables dnsmasq
  doas pacman --noconfirm --needed -S ebtables
  doas pacman --noconfirm --needed -S edk2-ovmf
  #sudo pacman --noconfirm --needed -S firewalld
  doas pacman --noconfirm --needed -S cdrtools
  doas pacman --noconfirm --needed -S iptables
  doas pacman --noconfirm --needed -S virtio-win

  # sudo pacman -Qi ebtables iptables dnsmasq

  doas systemctl start libvirtd
  doas systemctl enable libvirtd --now
  doas systemctl enable iptables --now
  doas systemctl status libvirtd
  doas systemctl status iptables

  doas usermod -a -G libvirt "$(id -un)"
  doas usermod -a -G kvm "$(id -un)"

  virsh list --all
  virsh net-autostart default
  virsh net-list --all
  getent group kvm libvirt qemu
  echo "reboot system to fix virt network"
elif [ "$OS" = "Solus" ]; then
  echo
  doas eopkg install -y libvirt
  # sudo eopkg install -y virt-manager
  doas usermod -a -G libvirt "$(id -un)"
  doas usermod -a -G kvm "$(id -un)"
  doas usermod -a -G qemu "$(id -un)"
  doas systemctl enable libvirtd --now
  # sudo systemctl start libvirtd
  virsh list --all
  virsh net-autostart default
  virsh net-list --all
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse bridge-utils
  sudo emerge --update --newuse app-emulation/libvirt
  doas emerge --update --newuse libvirt
  doas emerge --update --newuse virtio-win
  doas emerge --update --newuse libvirt-glib
  doas emerge --update --newuse libvirt-python
  sudo emerge --update --newuse app-emulation/virt-viewer
  sudo emerge --update --newuse net-misc/spice-gtk
  doas emerge --update --newuse virt-manager
  sudo emerge --update --newuse sys-firmware/edk2-ovmf ## uefi support
  sudo mv -v "$HOME/tmp/libvirtd.conf" /etc/libvirt/libvirtd.conf
  # sudo rc-update add libvirtd default
  # sudo rc-service libvirtd start
  doas systemctl enable libvirtd --now
  # sudo systemctl start libvirtd
  doas usermod -a -G libvirt "$(id -un)"
  doas usermod -a -G kvm "$(id -un)"
  doas usermod -a -G qemu "$(id -un)"
  echo grep KVM /usr/src/linux/.config
  lsmod | grep kvm
elif [ "$OS" = "Fedora Linux" ]; then
  #sudo dnf remove -y seabios-bin
  doas dnf install -y seabios-bin
  doas dnf install -y virt-install
  doas dnf install -y virt-viewer
  doas dnf install -y libvirt
  doas dnf install -y edk2-ovmf
  doas dnf install -y qemu
  doas dnf install -y virt-manager
  doas usermod -a -G libvirt "$(id -un)"
  doas usermod -a -G kvm "$(id -un)"
  doas usermod -a -G qemu "$(id -un)"
  # sudo systemctl start libvirtd
  doas systemctl enable libvirtd --now
  virsh list --all
  virsh net-autostart default
  virsh net-list --all
elif [ "$OS" = "CentOS Linux" ]; then
  #sudo yum remove -y seabios-bin
  doas yum install -y seabios
  doas yum install -y seabios-bin
  doas yum install -y virt-install
  doas yum install -y libvirt
  doas yum install -y qemu
  doas yum install -y virt-manager
  doas usermod -a -G libvirt "$(id -un)"
  doas usermod -a -G kvm "$(id -un)"
  # sudo systemctl start libvirtd
  doas systemctl enable libvirtd --now
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

echo kvm-ok
kvm-ok

echo sudo mv -v "$HOME/tmp/80-libvirt.rules" /etc/polkit-1/rules.d/80-libvirt.rules
echo virsh -c test:///default list --all
echo virsh -c qemu:///system list --all

exit 0

# vim: set ft=sh:
