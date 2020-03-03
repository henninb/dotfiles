#!/bin/sh


cd $HOME/projects
git clone git@github.com:phuhl/linux_notification_center.git deadd
cd deadd
make
sudo make install

exit 0
