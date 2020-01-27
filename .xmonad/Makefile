all:

all:
	@rm -rf rice simple test master
master:
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-master.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@touch .master
	@mv -v xmonad ${HOME}/.local/bin
	@hlint xmonad-master.hs
test:
	@rm -rf *.hi *.o
	@ln -sfn xmonad-test.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@touch .test
	@mv -v xmonad ${HOME}/.local/bin
	@hlint xmonad-test.hs
simple:
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-simple.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@touch .simple
	@mv -v xmonad ${HOME}/.local/bin
	@hlint xmonad-simple.hs
rice:
	@rm -rf *.hi *.o lib/*.o lib/*.hi xmonad
	@ln -sfn xmonad-rice.hs xmonad.hs
	@stack ghc -- --make xmonad.hs -i -ilib -fforce-recomp
	@rm -rf *.hi *.o lib/*.o lib/*.hi
	@touch .rice
	@mv -v xmonad ${HOME}/.local/bin
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
