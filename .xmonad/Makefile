all:
	@make polybar
master:
	@echo stack init .
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-master.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	echo master > .active
	@sudo mv -v xmonad /usr/local/bin
	@hlint xmonad-master.hs
test:
	@echo stack init .
	@rm -rf *.hi *.o
	@ln -sfn xmonad-test.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@echo test > .active
	@sudo mv -v xmonad /usr/local/bin
	@hlint xmonad-test.hs
ws:
	@echo stack init .
	@rm -rf *.hi *.o
	@ln -sfn xmonad-ws.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@echo ws > .active
	@sudo mv -v xmonad /usr/local/bin
	@hlint xmonad-ws.hs
simple:
	@echo stack init .
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-simple.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@echo simple > .active
	@sudo mv -v xmonad /usr/local/bin
	@hlint xmonad-simple.hs
polybar:
	@echo stack init .
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-polybar.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@echo polybar > .active
	@sudo mv -v xmonad /usr/local/bin
	@hlint xmonad-polybar.hs
rice:
	@stack path --local-bin
	@echo stack init .
	@rm -rf *.hi *.o lib/*.o lib/*.hi xmonad
	@ln -sfn xmonad-rice.hs xmonad.hs
	@stack ghc -- --make xmonad.hs -i -ilib -fforce-recomp
	@rm -rf *.hi *.o lib/*.o lib/*.hi
	@echo rice > .active
	@sudo mv -v xmonad /usr/local/bin
	@hlint xmonad-rice.hs
	@hlint lib/*.hs
example:
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-example.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
#	@stack ghc -- --make xmobar.hs
	@rm -rf *.hi *.o
	@echo example > .active
	@sudo mv -v xmonad /usr/local/bin
	@hlint xmonad-example.hs
restart:
	@echo restart xrdp
	@sudo systemctl restart xrdp
