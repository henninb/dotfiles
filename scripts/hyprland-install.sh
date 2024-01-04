#!/bin/sh

GENTOO_PKGS="rust-bin setxkbmap i3lock qalculate-gtk hddtemp feh xdotool dunst wmname w3m sys-apps/dbus flameshot volumeicon neofetch blueman dev-qt/qtwaylandscanner copyq clipmenu media-sound/mpc mpd net-wireless/blueman redshift playerctl net-misc/networkmanager numlockx nm-applet trayer-srg sxiv spacefm lxappearance hardinfo gentoolkit app-misc/jq pavucontrol neovim lsof"

FAILURE=""
ls -d /var/db/pkg/*/*| cut -f5- -d/
for i in $GENTOO_PKGS; do
if ! command -v "$i"; then
  if ! sudo emerge --update --newuse "$i"; then
      FAILURE="$i $FAILURE"
    fi
  fi
done

doas emerge --update --newuse app-eselect/eselect-repository
doas eselect repository enable guru
doas emaint sync -r guru
doas emerge --update --newuse hyprland
doas emerge --update --newuse gui-apps/waybar
doas emerge --update --newuse swappy
doas emerge --update --newuse grim
doas emerge --update --newuse wofi
doas emerge --update --newuse thunar
doas emerge --update --newuse swaylock
doas emerge --update --newuse kitty
doas emerge --update --newuse wl-clipboard

# doas emerge --update --newuse looking-glass
echo 'wlprop | jq -r '.name''
# eselect repository enable guru
# emaint sync -r guru
doas emerge --update --newuse xdg-desktop-portal-hyprland
doas emerge --update --newuse gui-libs/wlroots
doas emerge --update --newuse gui-apps/hyprland-plugins
doas emerge --update --newuse gui-apps/hyprpaper
doas emerge --update --newuse gui-apps/hyprpicker
doas emerge --update --newuse gui-wm/hyprland-contrib

exit 0
