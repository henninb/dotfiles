#!/bin/sh

ARCHLINUX_PKGS="setxkbmap i3lock qalculate-gtk hddtemp feh xdotool dunst wmname w3m flameshot volumeicon neofetch blueman qtwaylandscanner copyq clipmenu media-sound/mpc mpd blueman redshift playerctl network-manager numlockx nm-applet trayer-srg sxiv spacefm lxappearance hardinfo gentoolkit jq pavucontrol neovim lsof clipman gammastep ghostty obsidian android-tools"

GENTOO_PKGS="rust-bin setxkbmap i3lock qalculate-gtk hddtemp feh xdotool dunst wmname w3m sys-apps/dbus flameshot volumeicon neofetch blueman dev-qt/qtwaylandscanner copyq clipmenu media-sound/mpc mpd net-wireless/blueman redshift playerctl net-misc/networkmanager numlockx nm-applet trayer-srg sxiv spacefm lxappearance hardinfo gentoolkit app-misc/jq pavucontrol neovim lsof clipman gammastep dmidecode ghostty wlr-randr obsidian"

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  FAILURE=""
  for i in $ARCHLINUX_PKGS; do
    if ! sudo pacman --noconfirm --needed -S "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  doas pacman --noconfirm --needed -S hyprland
  doas pacman --noconfirm --needed -S waybar
  doas pacman --noconfirm --needed -S swappy
  doas pacman --noconfirm --needed -S grim
  doas pacman --noconfirm --needed -S swaync
  doas pacman --noconfirm --needed -S wofi
  doas pacman --noconfirm --needed -S cliphist
  doas pacman --noconfirm --needed -S thunar
  doas pacman --noconfirm --needed -S swaylock
  doas pacman --noconfirm --needed -S wlr-randr
  doas pacman --noconfirm --needed -S wlogout
  doas pacman --noconfirm --needed -S kitty
  doas pacman --noconfirm --needed -S wl-clipboard
  doas pacman --noconfirm --needed -S mako
  doas pacman --noconfirm --needed -S vulkan-tools
  doas pacman --noconfirm --needed -S dracut
  doas pacman --noconfirm --needed -S mesa-progs
  doas pacman --noconfirm --needed -S xdg-desktop-portal-hyprland
  doas pacman --noconfirm --needed -S wlroots
  doas pacman --noconfirm --needed -S hyprpaper
  doas pacman --noconfirm --needed -S hyprpicker
  doas pacman --noconfirm --needed -S brightnessctl
  doas pacman --noconfirm --needed -S hyprland-contrib
  sudo pacman --noconfirm --needed -S ttf-nerd-fonts-symbols
  yay --noconfirm --needed -S wlogout
  yay --noconfirm --needed -S hyprshot
  yay --noconfirm --needed -S hyprlock
  yay --noconfirm --needed -S hypridle
  yay --noconfirm --needed -S hyprpicker
  yay --noconfirm --needed -S deckmaster
  yay --noconfirm --needed -S mullvad-vpn-bin

  # doas pacman --noconfirm --needed -S xdg-desktop-portal-wlr
  # doas pacman --noconfirm --needed -S xdg-desktop-portal
else
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
  doas emerge --update --newuse hyprshot
  doas emerge --update --newuse hyprlock
  doas emerge --update --newuse hypridle
  doas emerge --update --newuse cliphist
  doas emerge --update --newuse thunar
  doas emerge --update --newuse swaylock
  doas emerge --update --newuse wlogout
  doas emerge --update --newuse kitty
  doas emerge --update --newuse wl-clipboard
  doas emerge --update --newuse gui-apps/mako
  doas emerge --update --newuse dev-util/vulkan-tools
  doas emerge --update --newuse dracut
  doas emerge --update --newuse x11-apps/mesa-progs
  doas emerge --update --newuse xdg-desktop-portal-hyprland
  doas emerge --update --newuse gui-libs/wlroots
  # doas emerge --update --newuse gui-apps/hyprland-plugins
  doas emerge --update --newuse gui-apps/hyprpaper
  doas emerge --update --newuse gui-apps/hypridle
  doas emerge --update --newuse gui-apps/hyprlock
  doas emerge --update --newuse gui-apps/hyprpicker
  doas emerge --update --newuse gui-wm/hyprland-contrib
  doas emerge --update --newuse sys-fs/fuse:0
  doas emerge --update --newuse gnome-keyring
  doas emerge --update --newuse net-vpn/mullvadvpn-app


  # doas emerge --update --newuse  xdg-desktop-portal-wlr
  # doas emerge --update --newuse  xdg-desktop-portal
fi

# doas emerge --update --newuse looking-glass
echo 'wlprop | jq -r '.name''
# eselect repository enable guru
# emaint sync -r guru

mkdir -p "$HOME/projects/github.com/Horus645"
cd "$HOME/projects/github.com/Horus645" || exit
git clone git@github.com:Horus645/swww.git
cd ./swww || exit
cargo build --release
#sudo cargo install --path /usr/bin
sudo mv target/release/swww /usr/bin
sudo mv target/release/swww-daemon /usr/bin

mkdir -p "$HOME/keepass-git"
cd "$HOME/keepass-git" || exit
git init .
# git remote add origin pi:/home/pi/downloads/keepass-git
git remote add raspi pi:/home/pi/downloads/keepass-git
git remote add origin ssh://git@gitlab.lan:2222/henninb/keepass-git.git
git branch --set-upstream-to=origin/main main
git fetch
git merge origin/main

mkdir -p "$HOME/files"
cd "$HOME/files" || exit
git init .
git remote add origin ssh://git@gitlab.lan:2222/henninb/backup-files.git
git branch --set-upstream-to=origin/main main
git fetch
git merge origin/main

systemctl --user status xdg-desktop-portal-hyprland

exit 0
