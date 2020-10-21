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
cd /etc/systemd/system
rm display-manager.service
sudo systemctl list-unit-files

view the logs
sudo journalctl

To boot to console:
sudo systemctl set-default multi-user
You must then edit /etc/default/grub by removing splash from the GRUB command line. (Remember to update GRUB afterward: sudo update-grub).
To get to the Unity desktop from the console, you must enter the command:
sudo systemctl start lightdm.service
(The usual startx command doesn't work with Unity.)
To restore boot to GUI:
sudo systemctl set-default graphical

## solus sleeps after 20 minutes
```
systemctl mask sleep suspend hibernate hybrid-sleep
```

## fix shell to a POXIX shell (Archlinux)
sudo ln -sfT /bin/dash /bin/sh

## howto server up markdown in a browser
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
systemctl disable systemd-networkd-wait-online.service

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
- sudo vim /etc/profile.d/external_monitor_resol.sh
