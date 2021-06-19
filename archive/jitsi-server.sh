#!/bin/sh

wget -qO - https://download.jitsi.org/jitsi-key.gpg.key | sudo apt-key add -

sudo sh -c "echo 'deb https://download.jitsi.org stable/' > /etc/apt/sources.list.d/jitsi-stable.list"

sudo apt-get -y update


# Install the full suite:
sudo apt-get -y install jitsi-meet

# or only the packages you need like for example:
# sudo apt -y install jitsi-videobridge
# sudo apt -y install jicofo
# sudo apt -y install jigasi

echo 443 is the default port

exit 0
