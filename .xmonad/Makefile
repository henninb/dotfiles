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
	@rm -rf *.hi *.o
	@cp xmonad xmonad-x86_64-linux
	@sudo mv -v xmonad /usr/local/bin
	@hlint xmonad.hs
freebsd:
	@echo build freebsd
	@rm -rf *.hi *.o xmonad
	@ln -sfn xmonad-freebsd.hs xmonad.hs
	@stack ghc -- --make xmonad.hs
	@rm -rf *.hi *.o
	@cp xmonad xmonad-x86_64-freebsd
	@sudo mv -v xmonad /usr/local/bin
#@cp /usr/local/bin/xmonad ~/.xmonad/xmonad-x86_64-freebsd
	@hlint xmonad.hs
rice:
	@echo build rice
	@stack path --local-bin
	@echo stack init .
	@rm -rf *.hi *.o lib/*.o lib/*.hi xmonad
	@ln -sfn xmonad-rice.hs xmonad.hs
	@stack ghc -- --make xmonad.hs -i -ilib -fforce-recomp
	@rm -rf *.hi *.o lib/*.o lib/*.hi
	@sudo mv -v xmonad /usr/local/bin
# ifdef HLINT
	@hlint xmonad.hs
	@hlint lib/*.hs
# endif
