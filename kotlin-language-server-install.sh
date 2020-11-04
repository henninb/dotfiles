#!/bin/sh

cd "$HOME/projects" || exit
git clone --recurse-submodules git@github.com:fwcd/kotlin-language-server.git
cd kotlin-language-server || exit
./gradlew :server:installDist
# stack ./install.hs hls

exit 0
