#!/bin/sh

pkg-config --exists gtk+-3.0 && echo "gtk+ 3.0 is installed" || echo "gtk+ 3.0 is not installed"
pkg-config --exists gtk+-2.0 && echo "gtk+ 2.0 is installed" || echo "gtk+ 2.0 is not installed"

exit 0
