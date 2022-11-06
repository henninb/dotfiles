# Steam

## flatpak
```
/var/lib/flatpak/exports/bin/com.valvesoftware.Steam
```

## native steam data
```
~/.local/share/Steam
```

## flatpak steam game files
```
~/.var/app/com.valvesoftware.Steam/.local/share/Steam
```

## mintlinux
```
nohup /usr/games/steam > /dev/null 2>&1 &
```

## poe
open up firewall rules if needed

## dayz
Launch options are: -nosplash -skipintro -nolauncher
sudo sysctl -w vm.max_map_count=1048576
sudo sysctl -w vm.max_map_count=262144
sudo sysctl -w vm.max_map_count=524288

## backup or move steam files
```
ln -sfn /home/henninb/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/Path\ of\ Exile common/Path\ of\ Exile
cp appmanifest_238960.acf /home/henninb/.local/share/Steam/steamapps
```
