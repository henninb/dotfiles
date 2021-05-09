HLINT := $(shell command -v hlint 2> /dev/null)

all:
	@make default
dbus:
	@echo build dbus
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-dbus.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@sudo mv -v xmonad /usr/local/bin
	@hlint xmonad.hs
default:
	@echo build default
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-default.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o xmonad-x86_64-linux xmonad-x86_64-freebsd
	@sudo cp -v xmonad /usr/local/bin
	@cp -v xmonad xmonad-x86_64-linux
	@cp -v xmonad xmonad-x86_64-freebsd
	@hlint xmonad.hs
#@cp /usr/local/bin/xmonad ~/.xmonad/xmonad-x86_64-freebsd
	@hlint xmonad.hs
rice:
	@echo build rice
	@stack path --local-bin
	@echo stack init .
	@rm -rf *.hi *.o lib-rice/*.o lib-rice/*.hi xmonad
	@ln -sfn xmonad-rice.hs xmonad.hs
	@stack ghc -- --make xmonad.hs -i -ilib-rice -fforce-recomp
	@rm -rf *.hi *.o lib-rice/*.o lib-rice/*.hi
	@sudo mv -v xmonad /usr/local/bin
# ifdef HLINT
	@hlint xmonad.hs
	@hlint lib-rice/*.hs
# endif
