#!/bin/sh

sudo cp -v /etc/portage/package.accept_keywords /etc/portage/packag.accept_keyword.bak.$$
sudo cp -v package.accept_keywords /etc/portage/package.accept_keywords

sudo cp -v /etc/portage/package.license /etc/portage/package.license.bak.$$
sudo cp -v package.license /etc/portage/package.license

sudo cp -v /etc/portage/package.use/zz-autounmask /tmp/zz-autounmask.bak.$$
sudo cp -v zz-autounmask /etc/portage/package.use/zz-autounmask

sudo cp -v /etc/portage/make.conf /etc/portage/make.conf.bak.$$
sudo cp -v make.conf /etc/portage/make.conf

echo "ruby_targets_ruby25" | sudo tee -a /etc/portage/use.mask

#sudo mkdir -p /usr/portage/local/profiles
#echo $(hostname) |sudo tee /usr/portage/local/profiles/repo_name
echo emerge --info


exit 0
