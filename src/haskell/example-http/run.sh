#!/bin/sh

stack ghc -- --make example_http.hs -fforce-recomp
./example_http

exit 0
