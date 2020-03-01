#!/bin/bash

for i in $(seq 0 255); do
        printf "\e[0;48;5;${i}m %03d\e[0;38;5;${i}m %03d " $i $i
        [[ $i -eq 7 || $i -eq 15 || $i -eq 231 || $i -eq 239 || $i -eq 247 ]] && echo
        [[ $i -ge 15 && $i -le 231 && $(( ($i - 15) % 6 )) -eq 0 ]] && echo
done


echo
echo should be 256
tput colors

echo
echo /usr/share/terminfo/r/rxvt-256color to ~/.terminfo/r/rxvt-256color

echo di=🗀 🗎

echo
echo should be red
tput setab 160 && echo foo

exit 0
