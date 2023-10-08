#!/bin/sh

curl -fsSL https://tailscale.com/install.sh | sh
sudo systemctl start tailscaled
sudo tailscale up

exit 0
