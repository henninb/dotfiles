#!/bin/sh

stack ghc -- --make list.hs -fforce-recomp
./list

exit 0
