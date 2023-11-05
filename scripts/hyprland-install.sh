#!/bin/sh

doas emerge --update --newuse xdg-desktop-portal-hyprland
doas emerge --update --newuse hyprland
doas emerge --update --newuse gui-apps/waybar

doas emerge --update --newuse app-eselect/eselect-repository
doas eselect repository enable guru
doas emaint sync -r guru
# eselect repository enable guru
# emaint sync -r guru
doas emerge --update --newuse gui-libs/wlroots
doas emerge --update --newuse gui-apps/hyprland-plugins
doas emerge --update --newuse gui-apps/hyprpaper
doas emerge --update --newuse gui-apps/hyprpicker
doas emerge --update --newuse gui-wm/hyprland-contrib

exit 0
