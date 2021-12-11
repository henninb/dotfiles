#!/bin/sh

find /home/henninb/backgrounds/ -type f -name "*.jpg" | xargs sha256sum > input.txt
groovy jpeg-tool.groovy

exit 0
