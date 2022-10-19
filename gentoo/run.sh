#!/bin/sh

sudo mkdir -p /etc/portage/package.mask
sudo mkdir -p /etc/portage/package.accept_keywords
sudo mkdir -p /etc/portage/package.use
sudo mkdir -p /etc/portage/backup

sudo cp -v /etc/portage/package.accept_keywords/package.accept_keywords /etc/portage/backup/package.accept_keyword.bak.$$
sudo cp -v package.accept_keywords /etc/portage/package.accept_keywords/package.accept_keywords

sudo cp -v /etc/portage/package.license /etc/portage/backup/package.license.bak.$$
sudo cp -v package.license /etc/portage/package.license

sudo cp -v /etc/portage/package.use/zz-autounmask /etc/portage/backup/zz-autounmask.bak.$$
sudo cp -v zz-autounmask /etc/portage/package.use/zz-autounmask

sudo cp -v /etc/portage/package.mask/aa-autounmask /etc/portage/backup/aa-autounmask.bak.$$
sudo cp -v aa-autounmask /etc/portage/package.mask/aa-autounmask

sudo cp -v /etc/portage/make.conf /etc/portage/backup/make.conf.bak.$$
sudo cp -v make.conf /etc/portage/make.conf

sudo cp -v /etc/portage/package.unmask /etc/portage/backup/package.unmask.bak.$$
sudo cp -v package.unmask /etc/portage/package.unmask

sudo cp -v /etc/portage/package.env /etc/portage/backup/package.env.bak.$$
sudo cp -v package.env /etc/portage/package.env

#sudo cp -v /etc/portage/package.use/steam /tmp/steam.bak.$$
#sudo cp -v steam /etc/portage/package.use/steam

echo emerge --info

exit 0
