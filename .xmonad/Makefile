HLINT := $(shell command -v hlint 2> /dev/null)

all:
	@make default
master:
	@echo stack init .
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-master.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	echo master > .active
	@sudo mv -v xmonad /usr/local/bin
	@hlint xmonad-master.hs
default:
	@echo stack init .
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-default.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@echo default > .active
	@sudo mv -v xmonad /usr/local/bin
	@hlint xmonad-default.hs
rice:
	@stack path --local-bin
	@echo stack init .
	@rm -rf *.hi *.o lib/*.o lib/*.hi xmonad
	@ln -sfn xmonad-rice.hs xmonad.hs
	@stack ghc -- --make xmonad.hs -i -ilib -fforce-recomp
	@rm -rf *.hi *.o lib/*.o lib/*.hi
	@echo rice > .active
	@sudo mv -v xmonad /usr/local/bin
ifdef HLINT
	@hlint xmonad-rice.hs
	@hlint lib/*.hs
endif
