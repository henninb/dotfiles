#!/bin/sh

version="IntelliJIdea2021.2"
mkdir -p "$HOME/.config/JetBrains/${version}"
find "$HOME/.config/JetBrains/${version}" -type d -exec touch -t "$(date +'%Y%m%d%H%M')" {} \;
rm -rf "$HOME/.config/JetBrains/${version}/eval"
rm -rf "$HOME/.config/JetBrains/${version}/options/other.xml"
rm -rf "$HOME/.java/.userPrefs/jetbrains"

# echo
# ls -l "$HOME/.java/.userPrefs/"
# echo
# ls -l "$HOME/.config/JetBrains/${version}/"

exit 0
