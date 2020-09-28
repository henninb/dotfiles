#!/bin/sh

#sudo dnf -y install http://downloads.drone.io/master/drone.rpm
#sudo systemctl status drone

# cd projects
# git clone https://aur.archlinux.org/drone.git
# cd drone
yay -S drone

curl -L https://github.com/drone/drone-cli/releases/latest/download/drone_linux_amd64.tar.gz | tar zx
sudo install -t /usr/local/bin drone

exit 0
