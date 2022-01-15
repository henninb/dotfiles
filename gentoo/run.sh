#!/bin/sh

sudo mkdir -p /etc/portage/package.mask
sudo mkdir -p /usr/portage/profiles
echo "$(uname -n)" | sudo tee -a /usr/portage/profiles/repo_name

echo '=dev-python/docutils-0.18' | sudo tee -a /etc/portage/package.mask/docutils
# echo '=dev-python/docutils-0.17' | sudo tee -a /etc/portage/package.mask/docutils

sudo cp -v /etc/portage/package.accept_keywords /etc/portage/package.accept_keyword.bak.$$
sudo cp -v package.accept_keywords /etc/portage/package.accept_keywords

sudo cp -v /etc/portage/package.license /etc/portage/package.license.bak.$$
sudo cp -v package.license /etc/portage/package.license

sudo cp -v /etc/portage/package.use/zz-autounmask /tmp/zz-autounmask.bak.$$
sudo cp -v zz-autounmask /etc/portage/package.use/zz-autounmask

sudo cp -v /etc/portage/package.use/layman /tmp/layman.bak.$$
sudo cp -v layman /etc/portage/package.use/layman

sudo cp -v /etc/portage/make.conf /etc/portage/make.conf.bak.$$
sudo cp -v make.conf /etc/portage/make.conf

sudo cp -v /etc/portage/package.unmask /etc/portage/package.unmask.bak.$$
sudo cp -v package.unmask /etc/portage/package.unmask

# echo "ruby_targets_ruby27" | sudo tee -a /etc/portage/use.mask

#sudo mkdir -p /usr/portage/local/profiles
#echo $(hostname) |sudo tee /usr/portage/local/profiles/repo_name
echo emerge --info


exit 0
