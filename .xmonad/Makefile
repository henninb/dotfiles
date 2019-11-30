all: master
rice:
	@rm -rf *.hi *.o lib/*.o lib/*.hi xmonad
	@ln -sfn xmonad-rice.hs xmonad.hs
	@stack ghc -- --make xmonad.hs -i -ilib
	@rm -rf *.hi *.o lib/*.o lib/*.hi
master:
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-master.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
test:
	@rm -rf *.hi *.o
	@ln -sfn xmonad-test.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
simple:
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-simple.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o

# exec stack ghc \
#   -- \
#   --make xmonad.hs \
#   -i \
#   -ilib \
#   -fforce-recomp \
#   -main-is main \
#   -v \
#   -O2 \
#   -j$(nproc) \
#   -o "$1"
