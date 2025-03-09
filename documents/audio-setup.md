
## alsamixer
```
lsmod | grep audio
sudo usermod -a -G audio henninb
arecord -l
pacmd list-sinks
pacmd list-sinks| grep alsa_output
```

## gui mixer
```
pavucontrol
```

## sound cards
```
sudo pacman -S pulseaudio
pacmd list-cards
pacmd set-default-sink "alsa_output.usb-Plantronics_Plantronics_C320-M_39BC5ACC3196D045BBC6119BFD65C4BB-00.analog-stereo"
pacmd set-default-sink "alsa_output.usb-Plantronics_Plantronics_BT600_a7948520c773b04ea1ca0bb647761dc2-00.analog-stereo"
pacmd set-default-sink "alsa_output.usb-Blue_Microphones_Yeti_Stereo_Microphone_TS_2018_02_02_61506-00.analog-stereo"
pacmd set-default-sink 2
```

## mixer
```
alsamixer
cat /proc/asound/cards
```

## results
```
 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf7210000 irq 34
 1 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xf7080000 irq 17
```

## audio recorder
```
sudo zypper -y audio-recorder
```

## devices
```
cat /proc/asound/cards
 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xdf440000 irq 137
 1 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xdf080000 irq 17
 2 [BT600          ]: USB-Audio - Plantronics BT600
                      Plantronics Plantronics BT600 at usb-0000:00:14.0-2.1, full speed
 3 [Microphone     ]: USB-Audio - Yeti Stereo Microphone
                      Blue Microphones Yeti Stereo Microphone at usb-0000:00:14.0-10, full speed
```

sudo usermod -a -G audio henninb
arecord --list-pcms

vi /etc/modprobe.d/alsa-base.conf

sudo alsa force-reload

sudo usermod -a -G audio henninb
aplay --list-device
