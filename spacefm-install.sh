#!/bin/sh

sudo apt install -y spacefm udevil libudev-dev libffmpegthumbnailer-dev intltool libtool
sudo apt install -y libgtk2.0-dev

echo "add #include <sys/sysmacros.h> to the  src/main.c"

sudo xbps-install -y intltool
sudo xbps-install -y glib-devel
sudo xbps-install -S ffmpegthumbnailer
sudo xbps-install ffmpegthumbnailer-devel

cd "$HOME/projects"
git clone git@github.com:IgnorantGuru/spacefm.git
cd spacefm
./autogen.sh
make
sudo make install

exit 0

diff --git a/src/main.c b/src/main.c
index 645e2ec..9453a3b 100644
--- a/src/main.c
+++ b/src/main.c
@@ -23,6 +23,7 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#include <sys/sysmacros.h>
 
 #include <signal.h>
