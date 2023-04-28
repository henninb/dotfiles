#!/bin/sh

echo pulseaudio -k && sudo alsa force-reload
pulseaudio --check && (pulseaudio -k || sudo killall pulseaudio)
pactl list short sinks
pgrep pulseaudio
echo pacmd set-default-sink 1

# pulseaudio --check
# It normally prints no output, just exit code. 0 means running. Mine were not running, so I just advanced to step 3.

# If any instance is running:

# pulseaudio -k
# Finally, start pulseaudio again as a daemon:

# pulseaudio -D

exit 0

# vim: set ft=sh:
