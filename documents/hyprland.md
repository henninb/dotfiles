yay -S hyprland wofi hyprpaper alacritty

#!/bin/sh
export WLR_NO_HARDWARE_CURSORS=1
export WLR_RENDERER_ALLOW_SOFTWARE=1
exec Hyprland


exo-open
exo-open --working-directory %f --launch TerminalEmulator

hyprctl clients
hyprctl binds
hyprctl notify -1 10000 "rgb(ff1ea3)" "Hello everyone!"


exec-once = gnome-keyring-daemon --start --components=secrets # Fix Chrome not remembering password
