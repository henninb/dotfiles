#!/bin/sh

echo https://forums.freebsd.org/threads/can-usb-devices-be-directly-assigned-to-a-jail.77317/

sudo pkg install -y debootstrap
sudo debootstrap --no-check-gpg focal /compat/ubuntu

sudo kldload linux64

sudo mkdir -p /compat/ubuntu/dev/shm
sudo mkdir -p /compat/ubuntu/dev/fd

# /compat/ubuntu/etc/apt/apt.conf.d/00freebsd, containing a single line: APT::Cache-Start 251658240;.


cat > "$HOME/tmp/00freebsd" <<EOF
APT::Cache-Start 251658240;
EOF

cat > "$HOME/tmp/ubuntu-fstab" <<EOF
 # Device        Mountpoint              FStype          Options                      Dump    Pass#
devfs           /compat/ubuntu/dev      devfs           rw,late                      0       0
tmpfs           /compat/ubuntu/dev/shm  tmpfs           rw,late,size=1g,mode=1777    0       0
fdescfs         /compat/ubuntu/dev/fd   fdescfs         rw,late,linrdlnk             0       0
linprocfs       /compat/ubuntu/proc     linprocfs       rw,late                      0       0
linsysfs        /compat/ubuntu/sys      linsysfs        rw,late                      0       0
/tmp            /compat/ubuntu/tmp      nullfs          rw,late                      0       0
/home           /compat/ubuntu/home     nullfs          rw,late                      0       0
EOF

cat > "$HOME/tmp/sources.list" << EOF
deb http://archive.ubuntu.com/ubuntu focal main universe restricted multiverse
deb http://security.ubuntu.com/ubuntu/ focal-security universe multiverse restricted main
deb http://archive.ubuntu.com/ubuntu focal-backports universe multiverse restricted main
deb http://archive.ubuntu.com/ubuntu focal-updates universe multiverse restricted main
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

sudo apt install -y apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser
EOF

sudo mount -al
sudo mv -v /compat/ubuntu/etc/fstab /compat/ubuntu/etc/fstab.bak
sudo mv -v "$HOME/tmp/ubuntu-fstab" /compat/ubuntu/etc/fstab
sudo mv -v "$HOME/tmp/00freebsd" /compat/ubuntu/etc/apt/apt.conf.d/00freebsd
sudo mv -v "$HOME/tmp/sources.list" /compat/ubuntu/etc/apt/sources.list
sudo mv -v "$HOME/tmp/locale.gen" /compat/ubuntu/etc/locale.gen
chmod 755 "$HOME/tmp/install-brave.sh"
sudo mv -v "$HOME/tmp/install-brave.sh" /compat/ubuntu/install-brave.sh
echo ubuntu | sudo tee /compat/ubuntu/etc/hostname

sudo chroot /compat/ubuntu /bin/bash # python-pip

exit 0

# vim: set ft=sh:
