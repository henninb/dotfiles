dzen2.font:     xft:inconsolata:size=10:antialias=true

https://github.com/robm/dzen/blob/master/README

```
sudo emerge --update --newuse media-fonts/terminus-font
```

## set font
```
xset +fp /usr/share/fonts/terminus
```

echo "0 1 2 3 4 5 6 7 8 9" | dzen2 -p -w '1000' -h '15' -fg '#000000' -bg '#FFFFFF'
echo "^fg(#888974)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+7) 7 ^ca() ^fn()^fg()" | dzen2 -p -w '1000' -h '15' -fg '#000000' -bg '#FFFFFF'
echo "^fg(#888974)^ca(1,xdotool key super+7) 7 ^ca() ^fg()" | dzen2 -p -w '1000' -h '15' -fg '#000000' -bg '#FFFFFF'
echo "7" | dzen2 -p -w '1000' -h '15' -fg '#000000' -bg '#FFFFFF'
echo "1 2 3 4 5 6 7 8 9 0" | dzen2 -p -w '50' -h '15' -fg '#000000' -bg '#FFFFFF'

seq 1 9


## Example 1
```
echo "^fg(#663399)^fn(monofur for Powerline-12)^bg(#FFFFFF) ^ca(1,xdotool key super+1) 1 ^ca() ^bg()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+2) 2 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+3) 3 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+4) 4 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+5) 5 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+6) 6 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+7) 7 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+8) 8 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+9) 9 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+0) 0 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+NSP) NSP ^ca() ^fn()^fg() ^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+space)Main^ca()^fn()^fg() ^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+shift+x) Alacritty ^ca()^fn()^fg()" | dzen2 -p -w '100' -h '15' -fg '#000000' -bg '#FFFFFF'
```

## Example 2
```
echo "^fg(#663399)^fn(monofur for Powerline-12)^bg(#FFFFFF) ^ca(1,xdotool key super+1) A ^ca() ^bg()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+2) B ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+3) C ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+4) D ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+5) E ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+6) F ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+7) G ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+8) H ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+9) I ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+0) 0 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+NSP) NSP ^ca() ^fn()^fg() ^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+space)Main^ca()^fn()^fg() ^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+shift+x) Alacritty ^ca()^fn()^fg()" | dzen2 -p -x '0' -y '0' -h '14' -w '800' -ta 'l' -fg '#DDEEFF' -bg '#181512' -fn terminus
```

## Example 3
```
echo "^ca(1,xdotool key super+1) A ^ca()^ca(1,xdotool key super+1) B ^ca()"  | dzen2 -p -h '14' -w '800' -ta 'l' -fg '#DDEEFF' -bg '#181512'
```

## Example 4
```
echo "^fg(#663399)^fn(monofur for Powerline-12)^bg(#FFFFFF)^ca(1,xdotool key super+1) 1 ^ca()^bg()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+2) 2 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+3) 3 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+4) 4 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+5) 5 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12) ^ca(1,xdotool key super+6) 6 ^ca() ^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+7) 7 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+8) 8 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+9) 9 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+0) 0 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+NSP) NSP ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+space)Main^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+shift+x) Alacritty ^ca()^fn()^fg()" | dzen2 -p -w '1000' -ta l -fg '#000000' -bg '#FFFFFF'
```

## Example 5
```
echo "^fg(#000000)^fn(monofur for Powerline-12)^bg(#FFFFFF)^ca(1,xdotool key super+1) 1 ^ca()^bg()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+2) 2 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+3) 3 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+4) 4 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+5) 5 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+6) 6 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+7) 7 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+8) 8 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+9) 9 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+0) 0 ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+NSP) NSP ^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+space)Main^ca()^fn()^fg()^fg(#000000)^fn(monofur for Powerline-12)^ca(1,xdotool key super+shift+x) Alacritty ^ca()^fn()^fg()" | dzen2 -p -w '1500' -ta l -fg '#000000' -bg '#FFFFFF'
```

## Example 6
```
echo "^fg(#000000)^fn(monofur for Powerline-12)^bg(#FFFFFF)^ca(1,xdotool key super+1) 1 ^ca()^bg()^fn()^fg()^fg(#000000)^fn(monofur\ for\ Powerline-12)^ca(1,xdotool key super+2) 2 ^ca()^fn()^fg()^fg(#000000)^fn(monofur\ for\ Powerline-12)^ca(1,xdotool key super+3) 3 ^ca()^fn()^fg()^fg(#000000)^fn(monofur\ for\ Powerline-12)^ca(1,xdotool key super+4) 4 ^ca()^fn()^fg()^fg(#000000)^fn(monofur\ for\ Powerline-12)^ca(1,xdotool key super+5) 5 ^ca()^fn()^fg()^fg(#000000)^fn(monofur\ for\ Powerline-12)^ca(1,xdotool key super+6) 6 ^ca()^fn()^fg()^fg(#000000)^fn(monofur\ for\ Powerline-12)^ca(1,xdotool key super+7) 7 ^ca()^fn()^fg()^fg(#000000)^fn(monofur\ for\ Powerline-12)^ca(1,xdotool key super+8) 8 ^ca()^fn()^fg()^fg(#000000)^fn(monofur\ for\ Powerline-12)^ca(1,xdotool key super+9) 9 ^ca()^fn()^fg()^fg(#000000)^fn(monofur\ for\ Powerline-12)^ca(1,xdotool key super+0) 0 ^ca()^fn()^fg()^fg(#000000)^fn(monofur\ for\ Powerline-12)^ca(1,xdotool key super+NSP) NSP ^ca()^fn()^fg()^fg(#000000)^fn(monofur\ for\ Powerline-12)^ca(1,xdotool key super+space)Main^ca()^fn()^fg()^fg(#000000)^fn(monofur\ for\ Powerline-12)^ca(1,xdotool key super+shift+x) Alacritty ^ca()^fn()^fg()" | dzen2 -p -w '1500' -ta l -fg '#000000' -bg '#FFFFFF'
```
