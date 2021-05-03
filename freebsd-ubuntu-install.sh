#!/bin/sh

sudo pkg install debootstrap
sudo debootstrap --no-check-gpg bionic /compat/ubuntu

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

mount -al


cat > sources.list << EOF
deb http://archive.ubuntu.com/ubuntu bionic main universe restricted multiverse
deb http://security.ubuntu.com/ubuntu/ bionic-security universe multiverse restricted main
deb http://archive.ubuntu.com/ubuntu bionic-backports universe multiverse restricted main
deb http://archive.ubuntu.com/ubuntu bionic-updates universe multiverse restricted main
EOF


echo /compat/ubuntu/etc/apt/sources.list

sudo chroot /compat/ubuntu /bin/bashpython-pip


apt install libffi-dev
apt install zlib1g-dev
locale-gen
vi /etc/locale.gen
pyenv install 3.7.4
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
apt install bzip2 libreadline6 libreadline6-dev openssl
apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

exit 0
