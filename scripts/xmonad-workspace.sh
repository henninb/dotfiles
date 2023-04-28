#!/bin/sh

#xdotool get_desktop_viewport | awk '{print int($1/$(xdotool getdisplaygeometry | awk "{print \$1}")+1), int($2/$(xdotool getdisplaygeometry | awk "{print \$2}")+1)}' | xargs -I{} xprop -root _NET_DESKTOP_NAMES | sed -n "{}p" | sed 's/_NET_DESKTOP_NAMES(UTF8_STRING) = "//;s/"$//'

# xdotool get_desktop_viewport | awk '{printf("%.0f %.0f\n",$1/$3+1,$2/$4+1)}' | xargs -I{} xprop -root _NET_DESKTOP_NAMES | awk -v workspace=$(echo {}) '{if ($1 == "_NET_DESKTOP_NAMES") {gsub(/"/,"",$3); split($3, workspaces, ","); print workspaces[workspace]}}'
# xdotool get_desktop_viewport | awk '{printf("%.0f %.0f\n",$1/$3+1,$2/$4+1)}' | xargs -I{} xprop -root _NET_DESKTOP_NAMES | awk -F '"' '/_NET_DESKTOP_NAMES/ {split($2,a,", "); printf("%s\n",a[$1-1])}'

current_workspace=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $NF+1}' | xargs -I{} xprop -root _NET_DESKTOP_NAMES | awk -F '"' '/_NET_DESKTOP_NAMES/ {split($2,a,", "); printf("%s\n",a[$1-1])}')
#echo { workspaces = ["1:web", "2:dev", "3:chat", "4:files"]
xprop -root _NET_CURRENT_DESKTOP


current_workspace=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $NF}')

echo "Current workspace: $current_workspace"

exit 0

# vim: set ft=sh
