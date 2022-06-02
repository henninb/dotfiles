HLINT := $(shell command -v hlint 2> /dev/null)

all:
	@make default
default:
	@echo build default
	@rm -rf *.hi *.o xmonad
#	@ln -sfn xmonad-default.hs xmonad.hs
	@stack ghc -- --make xmonad.hs -ilib -fforce-recomp
	@find . -name "*.hi" | xargs rm
	@find . -name "*.o" | xargs rm
	@rm -rf xmonad-x86_64-linux xmonad-x86_64-freebsd
	@cp -v xmonad xmonad-x86_64-linux
	@cp -v xmonad xmonad-x86_64-freebsd
	@rm -v xmonad
	@hlint xmonad.hs
	@hlint lib/Local/*.hs
rice:
	@echo build rice
	@stack path --local-bin
	@echo stack init .
	@rm -rf *.hi *.o lib-rice/*.o lib-rice/*.hi xmonad
#	@ln -sfn xmonad-rice.hs xmonad.hs
	@stack ghc -- --make xmonad.hs -i -ilib-rice -fforce-recomp
	@find . -name "*.hi" | xargs rm
	@find . -name "*.o" | xargs rm
	@rm -rf xmonad-x86_64-linux xmonad-x86_64-freebsd
	@sudo cp -v xmonad /usr/local/bin
	@cp -v xmonad xmonad-x86_64-linux
	@cp -v xmonad xmonad-x86_64-freebsd
# ifdef HLINT
	@hlint xmonad.hs
	@hlint lib-rice/*.hs
# endif
