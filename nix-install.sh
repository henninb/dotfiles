#!/bin/sh

sudo eopkg install -y rsync
sudo rm -rf /etc/nix /nix /root/.nix-profile /root/.nix-defexpr /root/.nix-channels $HOME/.nix-profile $HOME/.nix-defexpr $HOME/.nix-channels

sh <(curl -L https://nixos.org/nix/install) --daemon

exit 0

example
https://github.com/endofunky/nix-config/tree/4b0332656f835f6b2fcbcfa27b4ea60576f0b7e3
