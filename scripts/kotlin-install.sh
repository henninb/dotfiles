#!/bin/sh

# get the latest version of Kotlin
#version=$(curl -s https://github.com/JetBrains/kotlin/releases/latest | grep -oE "v[0-9]+\.[0-9]+\.[0-9]+")
KOTLIN_VER=$(curl -s https://api.github.com/repos/JetBrains/kotlin/releases/latest | grep -oE '"tag_name": "[^"]+"' | cut -d'"' -f4)

KOTLIN_VER=$(echo $KOTLIN_VER | sed 's/^v//')

# print the version
echo $KOTLIN_VER


cd "$HOME/projects/" || exit
if [ ! -f "kotlin-compiler-${KOTLIN_VER}.zip" ]; then
  wget "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VER}/kotlin-compiler-${KOTLIN_VER}.zip"
  # wget "https://github.com/JetBrains/kotlin/releases/download/v1.4.0/kotlin-compiler-1.4.0.zip
fi
cd /opt || exit
sudo unzip -o "$HOME/projects/kotlin-compiler-${KOTLIN_VER}.zip"
echo "$KOTLIN_VER"

# curl -sSLO https://github.com/pinterest/ktlint/releases/download/0.39.0/ktlint
# curl -sSLO https://github.com/pinterest/ktlint/releases/download/0.39.0/ktlint
# chmod a+x ktlint
# echo sudo mv ktlint /usr/local/bin/
cd "$HOME/projects/" || exit
curl -sSLO https://github.com/pinterest/ktlint/archive/0.39.0.tar.gz

exit 0

# vim: set ft=sh:
