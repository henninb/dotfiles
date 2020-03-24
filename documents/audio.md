# audio setup

alsamixer
```
lsmod | grep audio
sudo usermod -a -G audio henninb
arecord -l
pacmd list-sinks
pacmd list-sinks| grep alsa_output
```

## wired
pacmd set-default-sink "alsa_output.usb-Plantronics_Plantronics_C320-M_39BC5ACC3196D045BBC6119BFD65C4BB-00.analog-stereo"

## wireless
pacmd set-default-sink "alsa_output.usb-Plantronics_Plantronics_BT600_a7948520c773b04ea1ca0bb647761dc2-00.analog-stereo"

