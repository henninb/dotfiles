#!/bin/sh

unset GEM_ROOT
unset GEM_HOME
unset GEM_PATH

VAGRANT_VER=2.2.6

if [ "$OS" = "Arch Linux" ]; then
  PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
  #sudo pacman -Rs vagrant
  sudo pacman --noconfirm --needed -S vagrant
  gem install formatador
  gem install bundler
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  if [ ! -f vagrant_${VAGRANT_VER}.deb ]; then
    wget -O vagrant_${VAGRANT_VER}.deb https://releases.hashicorp.com/vagrant/${VAGRANT_VER}/vagrant_${VAGRANT_VER}_x86_64.deb
  fi
  sudo dpkg -i vagrant_${VAGRANT_VER}.deb
  echo /opt/vagrant/bin/vagrant
  sudo apt install -y ruby`ruby -e 'puts RUBY_VERSION[/\d+\.\d+/]'`-dev
  sudo apt install -y vagrant
  sudo apt install -y zlib1g-dev libvirt-dev
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y libvirt-devel.x86_64
  if [ -z $(which vagrant) ]; then
    sudo yum install -y https://releases.hashicorp.com/vagrant/${VAGRANT_VER}/vagrant_${VAGRANT_VER}_x86_64.rpm
  fi
  #sudo yum install -y vagrant
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y libvirt-devel
  if [ -z $(which vagrant 2> /dev/null) ]; then
    sudo dnf install -y https://releases.hashicorp.com/vagrant/${VAGRANT_VER}/vagrant_${VAGRANT_VER}_x86_64.rpm
  fi
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge vagrant dev-ruby/pkg-config
else
  echo "OS=$OS not yet configured."
  exit 1
fi

# vagrant plugin list | grep pkg-config
# if [ $? -ne 0 ]; then
#   echo vagrant plugin install pkg-config --debug
#   vagrant plugin install pkg-config
#   if [ $? -ne 0 ]; then
#     echo failed to install pkg-config
#     exit 1
#   fi
# fi

# vagrant plugin list | grep vagrant-scp
# if [ $? -ne 0 ]; then
#   echo vagrant plugin install vagrant-scp
# fi

vagrant plugin list | grep vagrant-libvirt
if [ $? -ne 0 ]; then
  vagrant plugin install vagrant-libvirt
  if [ $? -ne 0 ]; then
    echo failed to install vagrant-libvirt
    exit 1
  fi
fi

# vagrant plugin list | grep vagrant-vmware-desktop
# if [ $? -ne 0 ]; then
#   vagrant plugin install vagrant-vmware-desktop
#   if [ $? -ne 0 ]; then
#     echo failed to install vagrant-vmware-desktop
#     exit 1
#   fi
# fi

# vagrant plugin list | grep veewee
# if [ $? -ne 0 ]; then
#   vagrant plugin install veewee
#   if [ $? -ne 0 ]; then
#     echo failed to install veewee
#     exit 1
#   fi
# fi

# vagrant plugin list | grep fog-libvirt
# if [ $? -ne 0 ]; then
#   vagrant plugin install fog-libvirt
#   if [ $? -ne 0 ]; then
#     echo failed to install fog-libvirt
#     exit 1
#   fi
# fi

# if [ ! -z "$(which virsh)" ]; then
#   sudo virsh net-autostart vagrant-libvirt
#   sudo virsh net-autostart default
# fi

echo vagrant plugin update
vagrant global-status
if [ ! -f vagrant-vmware-utility_1.0.7_x86_64.deb ]; then
  wget https://releases.hashicorp.com/vagrant-vmware-utility/1.0.7/vagrant-vmware-utility_1.0.7_x86_64.deb
fi

echo vagrant-qemu
echo vagrant-mutate
echo vagrant mutate precise32.box libvirt

cd projects
git clone https://github.com/chef/bento
echo packer build -only qemu -var 'headless=true' centos-7.6-x86_64.json
cd -

exit 0
