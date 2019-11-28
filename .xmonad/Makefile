all:
	@rm -rf *.hi *.o
	@xmonad --recompile
	@ghc xmonad -ilib
	@xmonad --recompile
	@rm -rf *.hi *.o
