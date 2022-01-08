#!/bin/sh

git clone https://github.com/fangfufu/Linux-Fake-Background-Webcam.git fake-background
echo ./fake.py --no-foreground --width 640 --height 480 --background-blur 0

exit 0
