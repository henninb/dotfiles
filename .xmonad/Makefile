all:
	@make master
master:
	@echo need to learn about the stack.yaml file
	@echo stack init .
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-master.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	echo master > .active
	@mv -v xmonad ${HOME}/.local/bin
	@hlint xmonad-master.hs
test:
	@echo need to learn about the stack.yaml file
	@echo stack init .
	@rm -rf *.hi *.o
	@ln -sfn xmonad-test.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@echo test > .active
	@mv -v xmonad ${HOME}/.local/bin
	@hlint xmonad-test.hs
simple:
	@echo need to learn about the stack.yaml file
	@echo stack init .
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-simple.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@echo simple > .active
	@mv -v xmonad ${HOME}/.local/bin
	@hlint xmonad-simple.hs
rice:
	@stack path --local-bin
	@echo need to learn about the stack.yaml file
	@echo stack init .
	@rm -rf *.hi *.o lib/*.o lib/*.hi xmonad
	@ln -sfn xmonad-rice.hs xmonad.hs
	@stack ghc -- --make xmonad.hs -i -ilib -fforce-recomp
	@rm -rf *.hi *.o lib/*.o lib/*.hi
	@echo rice > .active
	@mv -v xmonad ${HOME}/.local/bin
	@hlint xmonad-rice.hs
	@hlint lib/*.hs
example:
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-example.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
#	@stack ghc -- --make xmobar.hs
	@rm -rf *.hi *.o
	@echo example > .active
	@mv -v xmonad ${HOME}/.local/bin
	@hlint xmonad-example.hs
