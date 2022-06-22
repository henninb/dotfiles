#!/bin/sh

KOTLIN_VER=$(curl -s https://blog.jetbrains.com/kotlin/category/releases/ | grep -io "Kotlin [0-9.]\+[0-9] released" | head -1 | grep -o '[0-9.]\+[0-9]')
#KOTLIN_VER=1.3.61

if [ -z "${KOTLIN_VER##[0-9]*\.[0-9]*\.[0-9]*}" ]; then
  echo "$KOTLIN_VER"
else
  KOTLIN_VER=$KOTLIN_VER.0
  echo "$KOTLIN_VER"
fi

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

