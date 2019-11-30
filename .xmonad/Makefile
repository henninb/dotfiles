all: master
rice:
	@ln -sfn xmonad-rice.hs xmonad.hs
	@rm -rf *.hi *.o
	@xmonad --recompile
	@ghc xmonad -ilib
	@xmonad --recompile
	@rm -rf *.hi *.o
master:
	@ln -sfn xmonad-master.hs xmonad.hs
	@rm -rf *.hi *.o
	@xmonad --recompile
test:
	@ln -sfn xmonad-test.hs xmonad.hs
	@rm -rf *.hi *.o
	@xmonad --recompile
simple:
	@ln -sfn xmonad-simple.hs xmonad.hs
	@rm -rf *.hi *.o
	@xmonad --recompile
