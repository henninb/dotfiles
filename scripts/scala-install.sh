#!/bin/sh

scala_ver=1.6.2
https://github.com/sbt/sbt/releases/download/v1.6.2/sbt-1.6.2.zip
if [ ! -f "sbt-${scala_ver}.zip" ]; then
  wget "https://github.com/sbt/sbt/releases/download/v${scala_ver}/sbt-${scala_ver}.zip"
fi
cd /opt || exit
sudo unzip -o "$HOME/sbt-${scala_ver}.zip"

exit 0

# vim: set ft=sh:
