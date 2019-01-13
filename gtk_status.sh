#!/bin/sh

pkg-config --exists gtk+-3.0 && echo "Installed" || echo "Not installed"

exit 0
