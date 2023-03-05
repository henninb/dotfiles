# **Issues List**

## freebsd - seeing this error in freebsd where freebsd is a virtual - /etc/rc.conf: firstboot-growfs=YES: not found
- no solution

## gentoo - using gnu screen with zsh, but having font issues inside screen. glyphs have turne into question marks. any idea how to address this?

- eselect locale list | grep US
- echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
- sudo locale-gen
- sudo eselect locale set 4

## tmux: need UTF-8 locale (LC_CTYPE) but have ANSI_X3.4-1968

- echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
- sudo locale-gen

## powerline not showing glyphs in console
- https://github.com/powerline/fonts/tree … rminus/PSF

Its up to you where you place the files, I put mine in /usr/share/fonts/PSF. You can test the font using the setfont command and make it permanent by creating or editing /etc/vconsole.conf

sudo mkdir -p /usr/share/fonts/PSF/
sudo cp ./.local/fonts/ter-powerline-v16b.psf /usr/share/fonts/PSF/
FONT=/usr/share/fonts/PSF/ter-powerline-v16b.psf

setfont /path/to/yourfont.ext
#For the fonts already installed you only need the name, so using gr737a-9x16.psfu.gz as an example:

BDF/PCF/PSF fonts are bitmap fonts meaning they describe a character as pixels in a grid.

setfont gr737a-9x16
To see the glyphs in the font, use:

showconsolefont

## kvm fails to start up - even if libvirtd runs as root it starts qemu with user:group defined into /etc/libvirt/qemu.conf (by default nobody:nobody)

- /etc/libvirt/qemu.conf that states qemu runs with group = wheel.

## gentoo - install vagrant, but getting "emerge: there are no ebuilds to satisfy ">=dev-ruby/erubis-2.7.0[ruby_targets_ruby25]"

- make.conf

## There was error while creating libvirt storage pool: Call to virStoragePoolDefineXML failed: operation failed: Storage source conflict with pool: 'images'

- virsh pool-destroy images
- virsh pool-undefine images

## gentoo  - sudo virsh net-start default
Unable to open /dev/net/tun
modprobe tun
can't initialize iptables table `nat': Table does not exist

IP_NF_NAT and IP6_NF_NAT to be enabled in your kernel configuration for USE=virt-network

## gentoo - when I set my package use to `>=dev-lua/mpack-1.0.4 luajit` I cannot get mpack to compile because `cannot find -lluajit-5.1` what can I look at to fix this emerge issue?

https://forums.gentoo.org/viewtopic-p-8351966.html

## mintlinux - Error loading module perl/core: /usr/local/lib/irssi/modules/libperl_core.so: cannot open shared object file: No such file or directory
- sudo apt install libperl-dev # do this before building irssi
- /load perl
- /script list

## irssi and having issue getting unregistered connections to channels
- set auth method SASL, https://freenode.net/kb/answer/sasl

## dm111psp bridge mode - trying to disable to router capabilities on my Netgear ADSL2+ Modem dm111psp v2 for my Centrylink DSL service.  I have changed VCI 32 to support Century Link and set the device mode to Modem (Modem Only). On my DDWRT router I have set my connection type to PPPoE and put in my username and password from Century Link (for PPoE). My problem is I am not getting a connection and I don't know where my problem is. I am certain the ddwrt side is setup correctly. On my Netgear do I need to disable to firewall? Should I turn of NAT? Thanks.
default:
U: admin
P: password
IP: 192.168.0.1

ADSL Settings
1) change VCI 32

Basic Settings
1) Encapsulation
2) Login, password

Device Mode
1) Modem (Modem Only)

NAT settings?

https://forum.dd-wrt.com/phpBB2/viewtopic.php?t=320498&highlight=dm111psp

## awesome wm key bindings

- Mod1 is alt
- Mod4 is the key between alt and control
- use xmodmap to map keys

## xmonad xrdp

The xmonad.hs closely emulates the window division behaviors of Wmii / Orion / I3 / Ion, and other non-minimal tiling window managers (eg. not DWM, or other window managers of the strongly "minimalist" flavor). See xmonad.hs for more details...

It focuses heavily on the ability to manipulate multiple independent groups of windows one or more monitors, with a high degree of granularity. The current way that this is abstracted is through the use of LayoutScreens to pretend that the different "panes" of a Rectangle are in fact different screens. The user may work at a higher level of abstraction, not worrying about master-slave window relationships, nor excessively rigid "dynamic" window behavior.

This is particularly useful in a number of circumstances:

When using a widescreen monitor, and more efficient screen utilization of the screen space is desired
When using multiple monitors, and Xinerama or TWinView are unavailable
When using systems with limited or restrictive X servers, that are incapable of using XRender (xrdp sessions with the span option are a case in point for this functionality)

main = xmonad $ desktopConfig
    { startupHook = do
        rects <- xdisplays
        {- spawn xmobar -}
    }

## mirror list fails for centos 8

use the following url =  http://mirrorlist.centos.org/?release=8&arch=x86_64&repo=BaseOS

urxvt
Running urxvt --help 2>&1 | grep options: returns iso14755, unicode3, and frills among other things.

ranger issue W3MIMGDISPLAY
neofetch --w3m /path/to/image

## xmonad bar ricing
- https://gitlab.com/epsi-rns/dotfiles/tree/master/xmonad

## play audio via command line
- cvlc

## XDG_CONFIG_HOME for font stuff on archlinux

$HOME/.config
https://serverfault.com/questions/709777/xrdp-changing-path-environment-variable

2

## vim color support
This turned out to be me misunderstanding what the termguicolors option entails in Vim. The ayu colour theme actually requires Truecolor support, which Urxvt does not have.

There is a good explanation of colour support in terminals: https://gist.github.com/XVilka/8346728

This has finally given me a good enough reason to switch to Alacritty.

https://github.com/vim-scripts/256-jungle

## keyboard keys
- showkey -k
- sudo showkey -k

## Gentoo - Invalid MIT-MAGIC-COOKIE-1 key - startx
I had the same problem a while ago. It took me quite a while to figure out what was wrong. For me the problem was caused by dhcpcd changing my hostname to "localhost". It uses localhost as fallback in case the dhcp server doesn't set any hostname. I worked around the problem by setting "nohook hostname" in /etc/dhcpcd.conf.

A better workaround would be to get the hostname from `xauth list` and add it as a loopback address in /etc/hosts, so it's always valid.

## perl compile on Fedora
PERL="perl" perl /usr/share/perl5/ExtUtils/xsubpp -C++ -typemap /usr/share/perl5/ExtUtils/typemap -typemap 'typemap.iom' -typemap 'typemap' -prototypes ./rxvtperl.xs >rxvtperl.C
Can't open perl script "/usr/share/perl5/ExtUtils/xsubpp": No such file or directory

- Solution was to create a custom make file for Fedora

## Urxvt paste not working with middle mouse click - mintlinux
- this appears to be happening after enabling perl extentions
- fixed after removing a bad perl extention
- new extention is causing issue - bracketed-paste-magic:zle:47: not enough arguments for -U

## Urxvt paste is calling paste and color modules - mintlinux
- modules not working
- fixed after removing bad extention

## Urxvt zsh plugin (zsh-autosuggestions) not working?

## Archlinux starship prompt causing issue when cd to ~/.git
- no solution as of now

## "icons" fonts not displaying in lf (urxvt)
- seems to be an issue with Urxvt
- the icons (glyphs) display in termite
- https://github.com/powerline/powerline/issues/60

- I looked further into the lf font issue. I am using xrdp to access my arch box. When I remote into arch, that is when I am facing the font issue. when I access lf directly on the console the fonts are showing up just fine. This issue only happens in urxvt.

- issue is with font spacing, need to better understand the issue

## install the patches needed to get full functionality out of st

## discover the title of a linux window
```
xdotool getactivewindow
xprop
```

## ghc compiler issues - Can't find GHC-8.8.1
stack path
stack setup
$HOME/.stack/global-project/stack.yaml
resolver: lts-14.3
8.6.5
stack --resolver lts-14.24
stack --resolver lts-14.25
stack --resolver lts-14.27
stack --resolver ghc-8.6.5 setup
stack --resolver ghc-8.6.5 init

## unifying logitech tool
solaar

# xrdp failed to start
- https://github.com/neutrinolabs/xrdp/issues/911

## rice polybar
- https://github.com/Th0rgal/horus-nix-home

## startx permission issue
```shell
$ startx /usr/bin/i3 -- vt1
$ startx -- :1 vt5
```

## disk mounting issue
 /etc/polkit-1/rules.d/10-udisks.rules
 created a script for access

## fonts in polybar
```shell
# "Un-disable" bitmap fonts
sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf
# Clear the font cache
sudo fc-cache -f -v
```
install font awesome

## usb device issues
```
[ 3898.185671] usb 1-8.1: new full-speed USB device number 15 using xhci_hcd
[ 3898.213330] usb 1-8.1: Device not responding to setup address.
[ 3898.446318] usb 1-8.1: Device not responding to setup address.
[ 3898.652370] usb 1-8.1: device not accepting address 15, error -71
```

- did not work
`GRUB_CMDLINE_LINUX_DEFAULT="usbcore.autosuspend=-1"`
## issue with nvm
NVM is not compatible with the npm config "prefix" option
nvm unalias default

## issue with pacman timeout
sudo vi /etc/pacman.d/mirrorlist
- removed the bad mirror

## issues with xrdp authentication solus

cat /etc/pam.d/xrdp-sesman
- not sure how to fix this issue

## issue with tty1 on sulus - lack of console login
- workaround is to switch to tty2 CTL-Alt-F2
- list of linux display manager gdm gdm3 lightdm kdm sdm
eopkg history
cd /etc/systemd/system && rm sudo display-manager.service
sudo systemctl list-unit-files

## view the logs for systemd
```
sudo journalctl
```

## change to tty2
```
sudo chvt 2
```

## To boot to console solus
```
systemctl get-default
sudo systemctl set-default multi-user
sudo systemctl isolate runlevel3.target

sudo vim /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
sudo grub-mkconfig -o /boot/grub/grub.cfg
and modifying it into

GRUB_CMDLINE_LINUX_DEFAULT="text"
Now you need to update grub,

update-grub
```

## adjust grub as needed (removing splash as needed) and update grub
```
sudo vim /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## To get to the desktop from the console (The usual startx command doesn't work with graphical.)
```
sudo systemctl start lightdm.service
```

## To restore boot to Graphical
```
sudo systemctl set-default graphical
sudo systemctl set-default multi-user
```

## solus - shutoff the sleeps after 20 minutes
```
systemctl mask sleep suspend hibernate hybrid-sleep
```

## setup the shell to a POXIX shell in Archlinux
```
sudo ln -sfT /bin/dash /bin/sh
```

## howto serve up markdown in a browser
```
grip documents/index.md 0.0.0.0
cat README.md | grip --export - | less
```

## ssh known_hosts cleanup
```
ssh-keygen -f "$HOME/.ssh/known_hosts" -R "192.168.100.124"
```

## video card details
```
lspci | grep -i --color 'vga\|3d\|2d'
```

## solus startup with blank tty1
$(tty) == /dev/tty1 and $SHLVL == 1
xinit /usr/bin/gnome-session -- /usr/bin/X :0

## tty console switch
```
sudo chvt 7
sudo chvt 2
```

## tty console setup
- fix the tty setting in the file below
```
sudo vi /etc/logins.def
```

## info on the system environment
```
loginctl session-status
```

## steam on solus
Gtk-Message: 10:16:50.304: Failed to load module "gail"
Gtk-Message: 10:16:50.304: Failed to load module "atk-bridge"

## Fix Hard Disk Bad Sectors in Linux
```
sudo e2fsck -cfpv /dev/sda1
```

## network A start job is running for wait for network to be configured
```
systemctl disable systemd-networkd-wait-online.service
```

## steam lib issue
sudo apt update && sudo apt install libxtst6 libxrandr2 libglib2.0-0 libgtk2.0-0 libpulse0 libgdk-pixbuf2.0-0

STEAM_RUNTIME=0

## Is it possible to configure xmonad to move a program from desktop 1 to 4 (i.e. super+shift+4) and to move to screen 4 without typing super+4 after?
```
karetsu can you not just set a custom keybind to do that?
karetsu> the action being something like W.shift >>=
                 W.greedyView (I forget the actual functions, I'm
                 in windows)

W.shift >>= W.greedyView should abstract to take
                 whatever key you pass as the workspace number, its how you would've defined shift and greedyView in the first place I think
karetsu i.e. I have `"<S> S-", W.shift` as my key
                 binding for shift, I don't have to specify that for my 8 workspaces yeah, probably worth creating a new one just in
                 case reassigning has other implications or
                 breakages (sometimes you might just want to move something out the way?)
 fizzie https://wiki.haskell.org/Xmonad/Frequently_asked_questions#Replacing_greedyView_with_view shows the example of how
                to swap the default 'greedyView' with just 'view' (by using a list comprehension to do it for all 9 workspaces), you should be able to adapt that to your behavior.
 fizzie There's also a variant in
https://hackage.haskell.org/package/xmonad-contrib-0.16/docs/XMonad-Layout-IndependentScreens.html since IndependentScreens also
                involves changing the normal workspace switch keys.
```

loginctl user-status
Failed to create bus connection: No such file or directory
   77  sudo rc-update add dbus default
   72  sudo rc-service dbus start
   77  sudo rc-update add elogind default
   78  sudo rc-service elogind start


## setting screen resolution
- xrandr --size 1920x1080
- xrandr --output HDMI-1 --mode 1920x1080
- xrandr --output HDMI-0 --mode 1920x1080
- xrandr --output HDMI-0 --mode 2560x1440
- sudo vim /etc/profile.d/external_monitor_resol.sh

## imagemagick gentoo compile
- magick convert rose.jpg rose.png
- sudo EXTRA_ECONF="--with-png --with-jpeg" emerge imagemagick"

## jdt language server install
```
    install coc-java (:CocInstall coc-java)
    download the lastest snapshot of jdtls on http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
    decompress the tar.gz to a local folder (/home/luiz/jdtls in my case)
    add java.jdt.ls.home in coc-settings.json ("java.jdt.ls.home" : "/home/luiz/jdtls" in my case)
    open some java file
```

## treesitter issues
```
/home/henninb/.config/nvim/bundle/nvim-treesitter/parser
```

## jdt issue
the build path should include:src/main/java

## debugging linux applications
```
strace -o vim.strace vim finance_db-extra.sql
sudo strace -p 132313
```

## change the global editor in archlinux
```
sudo vi /etc/environment
```

## nvim version issue
NVIM v0.5.0-682-g997147e4b
Build type: RelWithDebInfo
LuaJIT 2.0.5
Error detected while processing /home/henninb/.config/nvim/bundle/nvim-treesitter/plugin/nvim-treesitter.vim:
line   15:
E5108: Error executing lua ...nfig/nvim/bundle/nvim-treesitter/lua/nvim-treesitter.lua:2: nvim-treesitter requires a more recent Neovim nigh
tly version!
Press ENTER or type command to continue


## Xorg issue with lightdm
```
xf86: remove device 0 /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/drm/card1
failed to find screen to remove

org: ../xserver/dix/privates.c:384: dixRegisterPrivateKey: Assertion `!global_keys[type].created' failed.
(EE)
(EE) Backtrace:
(EE) 0: /usr/lib/Xorg (xorg_backtrace+0x53) [0x55cf7e581f63]
(EE) 1: /usr/lib/Xorg (0x55cf7e43b000+0x151da5) [0x55cf7e58cda5]
(EE) 2: /usr/lib/libc.so.6 (0x7f22052fe000+0x3cf80) [0x7f220533af80]
(EE) 3: /usr/lib/libc.so.6 (gsignal+0x145) [0x7f220533aef5]
(EE) 4: /usr/lib/libc.so.6 (abort+0x116) [0x7f2205324862]
(EE) 5: /usr/lib/libc.so.6 (0x7f22052fe000+0x26747) [0x7f2205324747]
(EE) 6: /usr/lib/libc.so.6 (0x7f22052fe000+0x35646) [0x7f2205333646]
(EE) 7: /usr/lib/Xorg (dixRegisterPrivateKey+0x0) [0x55cf7e4d0870]
(EE) 8: /usr/lib/xorg/modules/libglamoregl.so (glamor_init+0xc9) [0x7f21f8077fb9]
(EE) 9: /usr/lib/xorg/modules/drivers/modesetting_drv.so (0x7f2205830000+0x140fd) [0x7f22058440fd]
(EE) 10: /usr/lib/Xorg (AddGPUScreen+0x10e) [0x55cf7e4b440e]
(EE) 11: /usr/lib/Xorg (0x55cf7e43b000+0x185eb9) [0x55cf7e5c0eb9]
(EE) 12: /usr/lib/Xorg (0x55cf7e43b000+0x1bb288) [0x55cf7e5f6288]
(EE) 13: /usr/lib/Xorg (0x55cf7e43b000+0x1bb52b) [0x55cf7e5f652b]
(EE) 14: /usr/lib/Xorg (InitInput+0xf5) [0x55cf7e5a6435]
(EE) 15: /usr/lib/Xorg (0x55cf7e43b000+0x39798) [0x55cf7e474798]
(EE) 16: /usr/lib/libc.so.6 (__libc_start_main+0xd5) [0x7f2205325b25]
(EE) 17: /usr/lib/Xorg (_start+0x2e) [0x55cf7e4755de]
(EE)
(EE)
Fatal server error:
(EE) Caught signal 6 (Aborted). Server aborting
(EE)
(EE)
Please consult the The X.Org Foundation support
	 at http://wiki.x.org
```

[root@arcolinux xinitrc.d]# ls
40-libcanberra-gtk-module.sh  50-systemd-user.sh  80xapp-gtk3-module.sh
[root@arcolinux xinitrc.d]# pwd
/etc/X11/xinit/xinitrc.d

## flameshot issues starting
/usr/bin/flameshot & bash -c "sleep 0.5 && /usr/bin/flameshot gui"
flameshot gui --delay 1000
qt5-qmake qt5-default qttools5-dev-tools


## blueman
```
(blueman-applet:9703): Gtk-WARNING **: 12:17:29.578: Theme parsing error: gtk-dark.css:6361:24: 'none' is not a valid color name
blueman-applet version 2.1.4 starting
Traceback (most recent call last):
  File "/bin/blueman-applet", line 42, in <module>
    BluemanApplet()
  File "/usr/lib/python3.9/site-packages/blueman/main/Applet.py", line 30, in __init__
    self.DbusSvc = DbusService("org.blueman.Applet", "org.blueman.Applet", "/org/blueman/applet",
  File "/usr/lib/python3.9/site-packages/blueman/main/DbusService.py", line 27, in __init__
    self._bus = Gio.bus_get_sync(bus_type)
gi.repository.GLib.Error: g-io-error-quark: Could not connect: Connection refused (39)
```

Unit dbus-org.freedesktop.home1.service not found
sudo mv  /usr/lib/security/pam_systemd_home.so  /usr/lib/security/pam_systemd_home.so.bak


## freeebsd nvidia display issue
"echo ' nvidia_load="YES" >> /boot/loader.conf" "echo ' linux_enable="YES" >> /etc/rc.conf"
sudo pkg install [nvidia driver 340 340 108_2](nvidia-driver-340-340.108_2)
❯ xrandr
xrandr: Failed to get size of gamma for output default
Screen 0: minimum 1024 x 768, current 1024 x 768, maximum 1024 x 768
default connected 1024x768+0+0 0mm x 0mm
   1024x768       0.00*

    45.882] (!!) More than one possible primary device found
[    45.882] (--) PCI: (0@0:2:0) 8086:0412:1458:d000 rev 6, Mem @ 0xf7400000/4194304, 0xd0000000/268435456, I/O @ 0x0000f000/64, BIOS @ 0x????????/65536
[    45.882] (--) PCI: (1@0:0:0) 10de:1401:1043:8520 rev 161, Mem @ 0xf6000000/16777216, 0xe0000000/268435456, 0xf0000000/33554432, I/O @ 0x0000e000/128, BIOS @ 0x???????
?/65536
[    46.185] (EE) No devices detected.
[    46.185] (EE)
Fatal server error:
[    46.185] (EE) no screens found(EE)
[    46.185] (EE)

-- 10de is nvidia
Bus ID "PCI:0:0:0"
Screen 0 "Screen0" 0 0

I would add a BusID in the Device section to identify which card to use.
/usr/local/etc/X11/xorg.conf.


## freebsd alacritty after nvidia driver install
Received multiple errors. Errors: `[OsError("Could not create EGL display object"), OsError("GL context creation failed")]`

## platformio freebsd

https://community.platformio.org/t/platformio-on-freebsd/16472/4

## xmonad settings
https://github.com/randomthought/xmonad-config/blob/master/xmonad.hs
https://github.com/pjones/xmonadrc/blob/trunk/src/XMonad/Local/Keys.hs

## conky dzen2 struts issue
uses checkDock to see if a window has the DOCK property set and then makes a strut for it, so I think your issue could be caused by the Conky window not properly advertising that property

```
WM_NAME:
  title =? "conky (freebsd)"
WM_CLASS:
  appName =? "conky"
  className =? "conky"
WM_WINDOW_ROLE:  not found.
```
solution: dzen2 if it is not compiled correctly will not get the struts and ultimately will not work correctly with xmonad in adding th space for the bar
use the dzen2 for the OS if possible.

works with these features
dzen-0.9.5-svn, (C)opyright 2007-2009 Robert Manea
Enabled optional features:  XPM  XFT XINERAMA


## if I have multiple floating windows (intellij project windows in my case) how can I toggle between them?
05:59 < electr0n> mod+{j+k} usually. depends if you changed your keybindings or not.
05:59 ::: Irssi: Join to #xmonad was synced in 185 secs
06:01 < henninb> thanks electr0n, I think I changed the mod keys however I might want them changed back :)

## slow sddm

Jan 11 05:43:23 arcolinux pipewire[5176]: spa.v4l2: '/dev/video0' VIDIOC_QUERYCTRL: Connection timed out
Jan 11 05:43:23 arcolinux pipewire-media-session[5177]: ms.core: error id:70 seq:286 res:-110 (Connection timed out): enum params id:1 (Spa>
Jan 11 05:43:23 arcolinux kernel: usb 3-8.2: Failed to query (GET_DEF) UVC control 7 on unit 2: -110 (exp. 2).

sudo journalctl -n 100

## gentoo python and doc
```
dev-python/docutils:0

  (dev-python/docutils-0.18.1:0/0::gentoo, ebuild scheduled for merge) USE="" ABI_X86="(64)" PYTHON_TARGETS="python3_9 (-pypy3) -python3_10 -python3_8" conflicts with
    <dev-python/docutils-0.18[python_targets_python3_9(-)] required by (dev-python/sphinx-4.3.2:0/0::gentoo, installed) USE="-doc -latex -test" ABI_X86="(64)" PYTHON_TARGETS="python3_9 (-pypy3) -python3_10 -python3_8"
    ^                    ^^^^
    <dev-python/docutils-0.18[python_targets_python3_9(-)] required by (dev-python/sphinx_rtd_theme-1.0.0:0/0::gentoo, installed) USE="-test" ABI_X86="(64)" PYTHON_TARGETS="python3_9 (-pypy3) -python3_10 -python3_8"
    ^                    ^^^^


sudo emerge -avuND --with-bdeps=y --backtrack=75 world
```

## gentoo Multiple package instances within a single package slot have been pulled into the dependency graph, resulting in a slot conflict
```
media-libs/libjpeg-turbo

qdepends -CQqqF '%{CAT}/%{PN}:%{SLOT}' '^dev-libs/libffi'
sudo emerge --ignore-default-opts -va1 --keep-going $(qdepends -CQqqF '%{CAT}/%{PN}:%{SLOT}' '^dev-libs/libffi')

qdepends -CQqqF '%{CAT}/%{PN}:%{SLOT}' '^dev-python/docutils'
sudo emerge --ignore-default-opts -va1 --keep-going $(qdepends -CQqqF '%{CAT}/%{PN}:%{SLOT}' 'dev-python/docutils')
equery depends dev-python/setuptools | sed 's/-[0-9]\{1,\}.*$//'

emerge -1av docutils


qdepends -CQqqF '%{CAT}/%{PN}:%{SLOT}' '^dev-libs/boost'
sudo emerge --ignore-default-opts -va1 --keep-going $(qdepends -CQqqF '%{CAT}/%{PN}:%{SLOT}' '^dev-libs/boost')
```

## gentoo upgradable packages
```
sudo emerge eix
sudo eix-update
eix --installed --upgrade --only-names
eix --installed --upgrade
eix -Iu --only-names
```

## gentoo no action for now
```
  (dev-python/docutils-0.18.1-r1:0/0::gentoo, ebuild scheduled for merge) USE="" ABI_X86="(64)" PYTHON_TARGETS="python3_10 python3_9 (-pypy3) (-python3_11) -python3_8" conflicts with
    <dev-python/docutils-0.18[python_targets_python3_9(-),python_targets_python3_10(-)] required by (dev-python/sphinx-4.5.0-r1:0/0::gentoo, installed) USE="-doc -latex -test" ABI_X86="(64)" PYTHON_TARGETS="python3_10 python3_9 (-pypy3) (-python3_11) -python3_8"
```


## stack ghc version
```
stack ghc -- --version
```

SPACESHIP_PYENV_SHOW is deprecated. Use SPACESHIP_PYTHON_SHOW instead           

SPACESHIP_KUBECONTEXT_SHOW is deprecated. Use SPACESHIP_KUBECTL_CONTEXT_SHOW instead                                                                           


systemctl disable --now systemd-homed
systemctl disable --now systemd-userdbd.service
systemctl disable --now systemd-userdbd.socket

## archlinux - failed to mount /boot
```
pacman -S linux
```

## dns issue
```
/etc/nsswitch.conf
hosts:      files dns myhostname
```

## set default web browser
```
sudo update-alternatives --config x-www-browser
xdg-settings get default-web-browser
xdg-settings set default-web-browser brave-bin.desktop
```

## update desktop files
update-desktop-database ~/.local/share/applications

## xdg desktop
/usr/libexec/xdg-desktop-portal  -v

## screensaver
xscreensaver-settings

## block size is important
sudo tune2fs -l /dev/sdb2 |grep "^Block size:"

## locate files
locate libstdc++.so

## conky test
conky -c ~/.config/conky/xmonad-bar-top-right  | dzen2 -dock -title-name top-right -p -x 1925 -ta r  -fg '#DDEEFF' -bg '#320C2D' -fn '-*-terminus-*-r-normal-*-18-*-*-*-*-*-*-*'

## Authorization required, but no authorization protocol specified
xhost si:localuser:root

## nix connection issue
You can disable ipv6. I am currently using networking.enableIPv6 = false; to avoid this issue.
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6

## nix update
nix-channel --update

## opensuse install nvidia
https://www.if-not-true-then-false.com/2022/opensuse-nvidia-guide/

## change default terminal cinnamon
gsettings set org.cinnamon.desktop.default-applications.terminal exec /home/henninb/.local/share/cargo/bin/alacritty
gsettings set org.cinnamon.desktop.default-applications.terminal exec-arg "-x"

## cinnamon backup and restore settings
dconf dump /org/cinnamon/ > cinnamon_desktop_backup
dconf load /org/cinnamon/ < cinnamon_desktop_backup

sudo apt install dconf-editor
 /org/cinnamon/desktop/keybindings/

## location of desktop files
/usr/share/applications
.local/share/applications
