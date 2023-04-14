# fonts

## disable hinting
Xft.hinting: false
xrdb -query | grep hinting
xrdb -merge ~/.Xresources

## dpi
xdpyinfo | grep -B 2 resolution

screen #0:
  dimensions:    3840x2160 pixels (602x341 millimeters)
  resolution:    162x161 dots per inch
