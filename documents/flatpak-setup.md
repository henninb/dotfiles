# Flatpak Setup

## Override theme globally
```
sudo flatpak override --filesystem=$HOME/.themes
```

## override theme on a per app basis
```
sudo flatpak override org.gnome.Calculator --filesystem=$HOME/.themes
```

## set environment variable
```
sudo flatpak override --env=GTK_THEME=my-theme
sudo flatpak override org.gnome.Calculator --env=GTK_THEME=my-theme
```
