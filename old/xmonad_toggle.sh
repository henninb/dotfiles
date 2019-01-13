#!/bin/sh

cp .xmonad/xmonad.hs.toggle .xmonad/xmonad.hs.stage
cp .xmonad/xmonad.hs .xmonad/xmonad.hs.toggle
cp .xmonad/xmonad.hs.stage .xmonad/xmonad.hs

xmonad --recompile

exit 0
