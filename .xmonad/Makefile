all:
	@rm -rf rice simple test master
	@touch .master
	@stack ghc -- --make xmonad.hs
master:
	@stack init . --force
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-master.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@touch .master
	@mv -v xmonad ${HOME}/.local/bin
	@hlint xmonad-master.hs
test:
	@stack init . --force
	@rm -rf *.hi *.o
	@ln -sfn xmonad-test.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@touch .test
	@mv -v xmonad ${HOME}/.local/bin
	@hlint xmonad-test.hs
simple:
	@stack init . --force
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-simple.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@touch .simple
	@mv -v xmonad ${HOME}/.local/bin
	@hlint xmonad-simple.hs
rice:
	@stack init . --force
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
