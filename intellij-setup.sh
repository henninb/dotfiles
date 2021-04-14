#!/bin/sh

mkdir -p "$HOME/.config/JetBrains/IntelliJIdea2021.1"
find ~/.config/JetBrains/IntelliJIdea2020.3 -type d -exec touch -t "$(date +'%Y%m%d%H%M')" {} \;
rm -rf "$HOME/.config/JetBrains/IntelliJIdea2020.3/eval"
rm -rf "$HOME/.config/JetBrains/IntelliJIdea2020.3/options/other.xml"
find ~/.config/JetBrains/IntelliJIdea2021.1 -type d -exec touch -t "$(date +'%Y%m%d%H%M')" {} \;
rm -rf "$HOME/.config/JetBrains/IntelliJIdea2021.1/eval"
rm -rf "$HOME/.config/JetBrains/IntelliJIdea2021.1/options/other.xml"
rm -rf ~/.java/.userPrefs/jetbrains

ls -l ~/.java/.userPrefs/
ls -l ~/.config/JetBrains/IntelliJIdea2020.3/
ls -l ~/.config/JetBrains/IntelliJIdea2021.1/

exit 0
