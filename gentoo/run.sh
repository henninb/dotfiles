#!/bin/sh

sudo mkdir -p /etc/portage/package.mask
sudo mkdir -p /etc/portage/package.accept_keywords
sudo mkdir -p /etc/portage/package.use

sudo cp -v /etc/portage/package.accept_keywords/package.accept_keywords /etc/portage/package.accept_keywords/package.accept_keyword.bak.$$
sudo cp -v package.accept_keywords /etc/portage/package.accept_keywords/

sudo cp -v /etc/portage/package.license /etc/portage/package.license.bak.$$
sudo cp -v package.license /etc/portage/package.license

sudo cp -v /etc/portage/package.use/zz-autounmask /tmp/zz-autounmask.bak.$$
sudo cp -v zz-autounmask /etc/portage/package.use/zz-autounmask

sudo cp -v /etc/portage/make.conf /etc/portage/make.conf.bak.$$
sudo cp -v make.conf /etc/portage/make.conf

sudo cp -v /etc/portage/package.unmask /etc/portage/package.unmask.bak.$$
sudo cp -v package.unmask /etc/portage/package.unmask

#sudo cp -v /etc/portage/package.use/steam /tmp/steam.bak.$$
#sudo cp -v steam /etc/portage/package.use/steam

echo emerge --info

exit 0
