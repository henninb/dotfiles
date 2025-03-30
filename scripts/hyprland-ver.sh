#!/bin/sh

ver=$(hyprctl -j version | jq -r '.version')
echo "installed=v${ver}"

# https://github.com/hyprwm/Hyprland/releases/download/v0.48.1/source-v0.48.1.tar.gz

hypr_ver=$(curl -s https://api.github.com/repos/hyprwm/Hyprland/tags | jq -r '.[0].name')
echo "latest=${hypr_ver}"

exit 0
