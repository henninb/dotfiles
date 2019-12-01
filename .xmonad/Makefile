all:

all:
	@rm -rf rice simple test master
master:
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-master.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@hlint xmonad-master.hs
test:
	@rm -rf *.hi *.o
	@ln -sfn xmonad-test.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@touch test
	@hlint xmonad-test.hs
simple:
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-simple.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@touch simple
	@hlint xmonad-simple.hs
rice:
	@rm -rf *.hi *.o lib/*.o lib/*.hi xmonad
	@ln -sfn xmonad-rice.hs xmonad.hs
	@stack ghc -- --make xmonad.hs -i -ilib -fforce-recomp
	@rm -rf *.hi *.o lib/*.o lib/*.hi
	@touch rice
	@hlint xmonad-rice.hs
	@hlint lib/*.hs

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
