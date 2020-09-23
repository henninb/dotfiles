#!/bin/sh


cd "$HOME/projects" || exit
git clone git@github.com:phuhl/linux_notification_center.git deadd
cd deadd || exit
make
sudo make install

exit 0
