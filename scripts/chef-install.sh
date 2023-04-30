#!/bin/sh

CHEF_PASSWORD="********"
mkdir -p "$HOME/projects"

if [ "$OS" = "Linux Mint" ]; then
  curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable
  if [ ! -f "chef-server-core_12.19.31-1_amd64.deb" ]; then
    wget https://packages.chef.io/files/stable/chef-server/12.19.31/ubuntu/18.04/chef-server-core_12.19.31-1_amd64.deb
  fi
  doas dpkg -i chef-server-core_12.19.31-1_amd64.deb
  doas gem install knife-block
elif [ "$OS" = "Ubuntu" ]; then
  echo here
  #curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable
  if [ ! -f "chef-server-core_12.19.31-1_amd64.deb" ]; then
  echo here1
    wget https://packages.chef.io/files/stable/chef-server/12.19.31/ubuntu/18.04/chef-server-core_12.19.31-1_amd64.deb
  fi
  doas dpkg -i chef-server-core_12.19.31-1_amd64.deb
  doas gem install knife-block
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  cd "$HOME/projects" || exit
  git clone https://aur.archlinux.org/chef-dk.git
  cd chef-dk || exit
  makepkg -si
  #gem install knife-block
  cd ..
else
  echo "$OS is not yet implemented."
  exit 1
fi

doas chef-server-ctl reconfigure
doas chef-server-ctl status
doas chef-server-ctl install chef-manage
doas chef-server-ctl org-create home "home servers" -f home.pem
doas sudo chef-server-ctl org-list
doas chef-server-ctl user-create henninb Brian Henning henninb@gmail.com "$CHEF_PASSWORD" -f henninb.pem
doas chef-server-ctl user-list
doas chef-server-ctl org-user-add home henninb --admin
echo admin user is created
doas gem install knife-block

chef generate cookbook test-cookbook

wget https://supermarket.chef.io/cookbooks/activemq/download -O activemq.tar.gz
wget https://supermarket.chef.io/cookbooks/java/download -O java.tar.gz

#~/.chef/knife.rb
knife configure

echo cannot run activemq
echo let chef server instsall postgres
echo sudo chef-server-ctl user-delete admin
echo sudo chef-server-ctl org-delete home

exit 0

# vim: set ft=sh:
