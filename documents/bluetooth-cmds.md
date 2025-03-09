
## common
```
[bluetooth]#
select <cmac>
scan on
trust <mmac>
pairable on
pair <mmac>
connect <mmac>
```


## issue
```
Jan 28 06:22:46 archlinux bluetoothd[560]: profiles/input/device.c:control_connect_cb() connect to 04:4B:ED:E1:49:49: Host is down (112)
Jan 28 06:24:10 archlinux bluetoothd[560]: profiles/input/device.c:control_connect_cb() connect to 04:4B:ED:E1:49:49: Host is down (112)
Jan 28 06:24:40 archlinux bluetoothd[560]: profiles/input/device.c:control_connect_cb() connect to 04:4B:ED:E1:49:49: Device or resource bu>
Jan 28 06:24:49 archlinux bluetoothd[560]: profiles/input/device.c:control_connect_cb() connect to 04:4B:ED:E1:49:49: Device or resource
```

## issue
pactl load-module module-loopback \
source=bluez_source.48_45_10_A0_27_97 \
sink=alsa_output.pci-0000_00_1b.0.analog-stereo

```
pactl unload-module module-bluetooth-discover
pactl load-module module-bluetooth-discover
```

