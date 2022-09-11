# tty commands

## via command line 
sudo chvt 3

## via keyboard
CTL+ALT+3


/usr/lib/systemd/system/getty@.service

/lib/systemd/system/getty\@.service

Now with the adoption of systemd /etc/inittab is empty. 
The tty configuration file is now /lib/systemd/system/getty\@.service. 
This file seems to use agetty instead of mgetty to manage the tty. 
agetty man page doesn't show the -p option, but you could reinstall mgetty and use it.
Or you could use the -n (no prompt) option with the -l (specify a login program) option and write a wrapper to /bin/login with your own prompt.
