#!/bin/sh

KOTLIN_VER=$(curl -s https://blog.jetbrains.com/kotlin/category/releases/ | grep -io "Kotlin [0-9.]\+[0-9] released" | head -1 | grep -o '[0-9.]\+[0-9]')
#KOTLIN_VER=1.3.61
echo "$KOTLIN_VER"

if [ ! -f "kotlin-compiler-${KOTLIN_VER}.zip" ]; then
  wget "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VER}/kotlin-compiler-${KOTLIN_VER}.zip"
fi
cd /opt || exit
sudo unzip -o "$HOME/kotlin-compiler-${KOTLIN_VER}.zip"
echo "$KOTLIN_VER"

exit 0
