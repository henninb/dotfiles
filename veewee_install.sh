#!/bin/sh

#veewee

sudo apt install libxml2-dev
sudo apt install libcurl4-gnutls-dev

sudo apt install libxslt1-dev libxml2-dev zlib1g-dev

gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby
curl -sSL https://get.rvm.io | sudo bash -s stable
rvm requirements
#veewee kvm define centos-64 https://github.com/emiddleton/veewee-kvm-template-centos-6.4-x86_64-minimal.git
#veewee kvm define gentoo-latest https://github.com/jedi4ever/veewee/tree/master/templates/gentoo-latest

sudo gem install veewee
sudo gem install veewee-templates-updater
sudo gem install ruby-libvirt
sudo gem install bundle
sudo gem install fog-libvirt
sudo gem install libvirt

git clone https://github.com/jedi4ever/veewee.git

echo veewee-templates-update
echo bundle exec veewee kvm templates
echo sudo find / -name mkmf.log

sudo apt install rbenv

exit 0
