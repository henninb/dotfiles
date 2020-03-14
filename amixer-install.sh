sudo xbps-install -S  ConsoleKit2

pulseaudio
 xbps-install -S alsa-utils


 voidbox ~  master [!] ❯ ln -s /etc/sv/alsa /var/service/                       -- INSERT --
ln: failed to create symbolic link '/var/service/alsa': Permission denied
voidbox ~  master [!] ❯ sudo ln -s /etc/sv/alsa /var/service/                  -- INSERT --
voidbox ~  master [!] ❯ sudo ln -s /etc/sv/dbus /var/service/                  -- INSERT --
voidbox ~  master [!] ❯ sudo ln -s /etc/sv/cgmanager /var/service/             -- INSERT --
voidbox ~  master [!] ❯ sudo ln -s /etc/sv/consolekit /var/service/            -- INSERT --
voidbox ~  master [!] ❯ sudo usermod -a -G pulse-access henninb                -- INSERT --
voidbox ~  master [!] ❯


in .xinitrc
start-pulseaudio-x11 &

pulseaudio --start
