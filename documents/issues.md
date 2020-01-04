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
