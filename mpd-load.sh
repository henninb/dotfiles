cd ~/media && find . -name '.mp3' -o -name '.flac'|sed -e 's%^./%%g' &gt; all.m3u;mpd ~/.config/mpd/mpd.conf && mpc clear;mpc load all.m3u;mpc update
