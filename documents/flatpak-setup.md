# flatpak setup

sudo flatpak override --filesystem=$HOME/.themes

Alternatively, you can do this at per-application base as well.

sudo flatpak override org.gnome.Calculator --filesystem=$HOME/.themes


sudo flatpak override --env=GTK_THEME=my-theme

sudo flatpak override org.gnome.Calculator --env=GTK_THEME=my-theme
