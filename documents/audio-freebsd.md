# audio freebsd

## setup
`cat /dev/sndstat`
Installed devices:
pcm0: <NVIDIA (0x0072) (HDMI/DP 8ch)> (play)
pcm1: <NVIDIA (0x0072) (HDMI/DP 8ch)> (play)
pcm2: <NVIDIA (0x0072) (HDMI/DP 8ch)> (play)
pcm3: <NVIDIA (0x0072) (HDMI/DP 8ch)> (play)
pcm4: <Intel Haswell (HDMI/DP 8ch)> (play)
pcm5: <Realtek ALC887 (Rear Analog)> (play/rec) default
pcm6: <Realtek ALC887 (Front Analog)> (play/rec)
pcm7: <USB audio> (play/rec)

`sudo sysctl hw.snd.default_unit=7`

/etc/sysctl.conf
hw.snd.default_unit=7
