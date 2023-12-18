#!/bin/sh

ver=2003.1.1.26

echo "https://r2---sn-jxou0gtapo3-hn2e.gvt1.com/edgedl/android/studio/ide-zips/${ver}/android-studio-${ver}-linux.tar.gz"

wget "https://r2---sn-jxou0gtapo3-hn2e.gvt1.com/edgedl/android/studio/ide-zips/2023.1.1.26/android-studio-2023.1.1.26-linux.tar.gz" -O "$HOME/tmp/android-studio-linux.tar.gz"

#wget "https://r2---sn-jxou0gtapo3-hn2e.gvt1.com/edgedl/android/studio/ide-zips/${ver}/android-studio-${ver}-linux.tar.gz" -O "$HOME/tmp/android-studio-linux.tar.gz"
# curl "https://r2---sn-jxou0gtapo3-hn2e.gvt1.com/edgedl/android/studio/ide-zips/2023.1.1.26/android-studio-2023.1.1.26-linux.tar.gz" -o "$HOME/tmp/android-studio-${ver}-linux.tar.gz"
# curl "https://r2---sn-jxou0gtapo3-hn2e.gvt1.com/edgedl/android/studio/ide-zips/${ver}/android-studio-${ver}-linux.tar.gz" -o "$HOME/tmp/android-studio-${ver}-linux.tar.gz"
#curl "https://dl.google.com/edgedl/android/studio/ide-zips/2003.1.1.26/android-studio-2003.1.1.26-linux.tar.gz" -o "$HOME/tmp/android-studio-${ver}-linux.tar.gz"

#curl "https://r2---sn-jxou0gtapo3-hn2e.gvt1.com/edgedl/android/studio/ide-zips/${ver}/android-studio-2023.1.1.26-linux.tar.gz" -o "$HOME/tmp/android-studio-${ver}-linux.tar.gz"
doas rm -rf /opt/android-studio/

cd "$HOME/tmp/" || exit
doas tar -xvf "android-studio-linux.tar.gz" -C /opt

exit 0

# vim: set ft=sh:
