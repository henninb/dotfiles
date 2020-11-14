#!/bin/sh

find ~/.config/JetBrains/IntelliJIdea2020.2 -type d -exec touch -t "$(date +'%Y%m%d%H%M')" {} \;
rm -rf "$HOME/.config/JetBrains/IntelliJIdea2020.2/eval"
rm -rf "$HOME/.config/JetBrains/IntelliJIdea2020.2/options/other.xml"
rm -rf ~/.java/.userPrefs/jetbrains

ls -l ~/.java/.userPrefs/
ls -l ~/.config/JetBrains/IntelliJIdea2020.2/

exit 0
