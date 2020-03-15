#!/bin/sh

#KOTLIN_VER=$(curl -s https://blog.jetbrains.com/kotlin/category/releases/ | grep -io "Kotlin [0-9.]\+[0-9] released" | head -1 | grep -o '[0-9.]\+[0-9]')
#KOTLIN_VER=1.3.61
#echo "$KOTLIN_VER"

if [ ! -f "sbt-1.3.8.zip" ]; then
  wget "https://piccolo.link/sbt-1.3.8.zip"
fi

cd /opt || exit
sudo unzip -o "$HOME/sbt-1.3.8.zip"

exit 0
