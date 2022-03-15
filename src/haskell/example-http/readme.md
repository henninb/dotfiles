#!/bin/sh

stack install aeson
stack install ekg
stack install QuickCheck
stack install wai
stack install warp
stack ghc -- --make example_http.hs -fforce-recomp
./example_http

exit 0
