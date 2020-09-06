## cmus
- plays music via the command line

# simple commands
```
cmus toggle
cmus prev
cmus next

cmus-remote --pause   #Play/Pause
cmus-remote --next    #Next song
cmus-remote --prev    #Previous song
cmus-remote --stop    #Stop
cmus-remote --seek -5 #Rewind 5 seconds
cmus-remote --seek +5 #Forward 5 seconds
```

# simple commands in add
```
:add ~/media
```

# startup (default is 3000)
cmus --listen 0.0.0.0:3100
sudo kill -9 "$(pidof cmus)"

cmus --plugins

:set mpris=false


v - stop playback
b - next track
z - previous track
c - pause playback
s - toggle shuffle
