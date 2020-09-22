#!/bin/sh

find ~/.IntelliJIdea* -type d -exec touch -t $(date +"%Y%m%d%H%M") {} \;
rm -rf "$HOME/.IntelliJIdea*/config/eval"
rm -rf "$HOME/.IntelliJIdea*/config/options/other.xml"
rm -rf ~/.java/.userPrefs/jetbrains

exit 0
