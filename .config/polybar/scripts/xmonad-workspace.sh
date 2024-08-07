#!/bin/bash

format_workspaces() {
  while read -r line; do
    echo "$line" \
      | sed 's/__active__/◆/g' \
      | sed 's/__urgent__/◆/g' \
      | sed 's/__hidden__/◆/g' \
      | sed 's/__empty__/◇/g' \
      #| sed 's/__active__/⬤/g' \
      #| sed 's/__urgent__/⬤/g' \
      #| sed 's/__hidden__/⬤/g' \
      #| sed 's/__empty__/⭕/g' \

      #| perl -pe 's/((?:%{F#888974*?}%{A1:.*} __empty__ %{A}%{F-} ?)*)(?!.*\1)//g'
    done
}



#if [ "$MONITOR" = "HDMI-A-1" ]; then
  #tail -F /tmp/xmonad-state-bar2 | stdbuf -o0 cat | format_workspaces
#elif [ "$MONITOR" = "DisplayPort-1" ]; then
  #tail -F /tmp/xmonad-state-bar0 | stdbuf -o0 cat | format_workspaces
#else
  #tail -F /tmp/xmonad-state-bar1 | stdbuf -o0 cat | format_workspaces
#fi


if [ "$MONITOR" = "HDMI-A-1" ]; then
  tail -F /tmp/xmonad-state-bar2 | stdbuf -o0 cat | format_workspaces
elif [ "$MONITOR" = "DisplayPort-1" ]; then
  tail -F /tmp/xmonad-state-bar1 | stdbuf -o0 cat | format_workspaces
else
  tail -F /tmp/xmonad-state-bar0 | stdbuf -o0 cat | format_workspaces
fi

exit 0
