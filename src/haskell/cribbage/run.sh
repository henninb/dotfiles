#!/bin/sh

stack ghc -- --make cribbage.hs -fforce-recomp
./cribbage

exit 0
