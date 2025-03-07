#!/bin/sh

stack ghc -- --make sidereal.hs -fforce-recomp
./sidereal

exit 0
