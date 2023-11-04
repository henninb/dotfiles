#!/bin/sh

systemctl get-default
echo doas systemctl set-default multi-user
echo doas systemctl set-default graphical

current_target=$(systemctl get-default)

if [ "$current_target" = "graphical.target" ]; then
    new_target="multi-user.target"
else
    new_target="graphical.target"
fi

sudo systemctl set-default "$new_target"
echo "Switched to $new_target mode."

exit 0
