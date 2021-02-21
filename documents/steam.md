# Steam

## flatpak
/var/lib/flatpak/exports/bin/com.valvesoftware.Steam

## native steam data
~/.local/share/Steam

## flatpak steam game files
~/.var/app/com.valvesoftware.Steam/.local/share/Steam


## mintlinux
  nohup /usr/games/steam > /dev/null 2>&1 &

## backup or move steam files
ln -sfn /home/henninb/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/Path\ of\ Exile common/Path\ of\ Exile
cp appmanifest_238960.acf /home/henninb/.local/share/Steam/steamapps
