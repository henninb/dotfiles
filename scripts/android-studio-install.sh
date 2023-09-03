#!/bin/sh

wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip
unzip commandlinetools-linux-6609375_latest.zip -d cmdline-tools
mkdir --parents "$ANDROID_HOME/cmdline-tools/latest"
#sudo mv cmdline-tools/* "$ANDROID_HOME/cmdline-tools/latest/"
#export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
exit 0

curl -s "https://r2---sn-jxou0gtapo3-hn2e.gvt1.com/edgedl/android/studio/ide-zips/2022.3.1.19/android-studio-2022.3.1.19-linux.tar.gz?cms_redirect=yes&mh=69&mip=97.116.132.108&mm=28&mn=sn-jxou0gtapo3-hn2e&ms=nvh&mt=1692833788&mv=m&mvi=2&pl=18&rmhost=r1---sn-jxou0gtapo3-hn2e.gvt1.com&shardbypass=sd" -o "$HOME/tmp/android-studio-2022.3.1.19-linux.tar.gz"
cd "$HOME/tmp/" || exit
doas tar -xvf android-studio-2022.3.1.19-linux.tar.gz -C /opt

exit 0

# vim: set ft=sh:
