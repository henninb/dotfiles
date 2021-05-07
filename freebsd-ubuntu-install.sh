#!/bin/sh

sudo pkg install debootstrap
sudo debootstrap --no-check-gpg focal /compat/ubuntu

sudo mkdir /compat/ubuntu/dev/shm
sudo mkdir /compat/ubuntu/dev/fd

/compat/ubuntu/etc/apt/apt.conf.d/00freebsd, containing a single line: APT::Cache-Start 251658240;.

cat > 00freebsd <<EOF
APT::Cache-Start 251658240;
EOF


cat > ubuntu-fstab <<EOF
 # Device        Mountpoint              FStype          Options                      Dump    Pass#
devfs           /compat/ubuntu/dev      devfs           rw,late                      0       0
tmpfs           /compat/ubuntu/dev/shm  tmpfs           rw,late,size=1g,mode=1777    0       0
fdescfs         /compat/ubuntu/dev/fd   fdescfs         rw,late,linrdlnk             0       0
linprocfs       /compat/ubuntu/proc     linprocfs       rw,late                      0       0
linsysfs        /compat/ubuntu/sys      linsysfs        rw,late                      0       0
/tmp            /compat/ubuntu/tmp      nullfs          rw,late                      0       0
/home           /compat/ubuntu/home     nullfs          rw,late                      0       0
EOF

sudo mount -al


cat > sources.list << EOF
deb http://archive.ubuntu.com/ubuntu focal main universe restricted multiverse
deb http://security.ubuntu.com/ubuntu/ focal-security universe multiverse restricted main
deb http://archive.ubuntu.com/ubuntu focal-backports universe multiverse restricted main
deb http://archive.ubuntu.com/ubuntu focal-updates universe multiverse restricted main
EOF


echo /compat/ubuntu/etc/apt/sources.list

sudo chroot /compat/ubuntu /bin/bash # python-pip

vi /etc/locale.gen
en_US.UTF-8 UTF-8
locale-gen

apt install libffi-dev
apt install zlib1g-dev


pyenv install 3.7.4
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
apt install -y bzip2 libreadline6 libreadline6-dev openssl
apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

echo https://forums.freebsd.org/threads/can-usb-devices-be-directly-assigned-to-a-jail.77317/

# brave install
sudo apt install -y apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

exit 0
