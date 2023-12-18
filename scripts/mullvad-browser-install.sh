#!/bin/sh

# wget https://mullvad.net/en/download/browser/linux64/latest -O "$HOME/tmp/mullvad-browser.tar.xz"
wget https://mullvad.net/en/download/browser/linux-x86_64/latest -O "$HOME/tmp/mullvad-browser.tar.xz"

doas tar -xvf "$HOME/tmp/mullvad-browser.tar.xz" -C /opt

sudo chown -R henninb:henninb /opt/mullvad-browser

# wget 'https://cdn.mullvad.net/browser/12.0.6/mullvad-browser-linux64-12.0.6_ALL.tar.xz' -O "$HOME/tmp/mullvad-browser-linux64-12.0.6_ALL.tar.xz"


exit 0

# vim: set ft=sh:
