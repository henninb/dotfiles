#!/bin/sh

doas pkg install -y debootstrap
sudo debootstrap --no-check-gpg focal /compat/debian

doas kldload linux64

sudo mkdir -p /compat/debian/dev/shm
sudo mkdir -p /compat/debian/dev/fd

cat > "$HOME/tmp/loader.conf" << EOF
# nano /boot/loader.conf
linux_load="YES"
linux64_load="YES"
fdescfs_load="YES"
linprocfs_load="YES"
tmpfs_load="YES"
linsysfs_load="YES"
EOF

cat > "$HOME/tmp/00freebsd" <<EOF
APT::Cache-Start 251658240;
EOF

cat > "$HOME/tmp/debian-fstab" <<EOF
 # Device        Mountpoint              FStype          Options                      Dump    Pass#
devfs           /compat/debian/dev      devfs           rw,late                      0       0
tmpfs           /compat/debian/dev/shm  tmpfs           rw,late,size=1g,mode=1777    0       0
fdescfs         /compat/debian/dev/fd   fdescfs         rw,late,linrdlnk             0       0
linprocfs       /compat/debian/proc     linprocfs       rw,late                      0       0
linsysfs        /compat/debian/sys      linsysfs        rw,late                      0       0
/tmp            /compat/debian/tmp      nullfs          rw,late                      0       0
/home           /compat/debian/home     nullfs          rw,late                      0       0
EOF

cat > "$HOME/tmp/sources.list" << EOF
deb http://archive.debian.com/debian focal main universe restricted multiverse
deb http://security.debian.com/debian/ focal-security universe multiverse restricted main
deb http://archive.debian.com/debian focal-backports universe multiverse restricted main
deb http://archive.debian.com/debian focal-updates universe multiverse restricted main
EOF

cat > "$HOME/tmp/locale.gen" <<EOF
en_US.UTF-8 UTF-8
EOF

cat > "$HOME/tmp/install-brave.sh" <<'EOF'
locale-gen
apt update -y
apt install -y curl
apt install -y libffi-dev
apt install -y zlib1g-dev

pyenv install 3.7.4
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
apt install -y bzip2 libreadline6 libreadline6-dev openssl
apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

doas apt install -y apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
doas apt update
doas apt install -y brave-browser
EOF

cp -v "$HOME/freebsd/linux-brave" "$HOME/.local/bin"

doas mount -al
if ! cat /etc/fstab | grep -q debian; then
  cat "$HOME/tmp/debian-fstab" | sudo tee -a /etc/fstab
fi
sudo mv -v "$HOME/tmp/00freebsd" /compat/debian/etc/apt/apt.conf.d/00freebsd
sudo mv -v "$HOME/tmp/sources.list" /compat/debian/etc/apt/sources.list
sudo mv -v "$HOME/tmp/locale.gen" /compat/debian/etc/locale.gen
chmod 755 "$HOME/tmp/install-brave.sh"
sudo mv -v "$HOME/tmp/install-brave.sh" /compat/debian/install-brave.sh
echo debian | sudo tee /compat/debian/etc/hostname
sudo cp -v "$HOME/freebsd/brave-wrapper" /compat/debian/opt/brave.com/brave/brave-wrapper
sudo cp -v "$HOME/freebsd/debian-rc" /usr/local/etc/rc.d/debian
sudo chmod 755 /usr/local/etc/rc.d/debian

cd /compat/debian/lib64 && sudo rm ./ld-linux-x86-64.so.2 && sudo ln -s ../lib/x86_64-linux-gnu/ld-2.31.so ld-linux-x86-64.so.2

doas sysrc debian_enable=YES
doas sysrc linux_enable=YES
doas sysrc dbus_enable=YES
doas sysrc hald_enable=YES
doas sysrc kld_list="linux nvidia nvidia-modeset"

sudo chroot /compat/debian /bin/bash

exit 0

# vim: set ft=sh:
