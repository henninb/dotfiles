#!/bin/sh

stack ghc -- --make fileread.hs -fforce-recomp
./fileread

exit 0
