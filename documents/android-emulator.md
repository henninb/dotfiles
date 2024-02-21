
emulator -avd Nexus_6_API_27-2 -http-proxy 192.168.10.40:8080
emulator -avd Nexus_6_API_27-2 -http-proxy 192.168.10.41:8080
emulator -list-avds
emulator -avd Nexus_6_API_27
emulator -avd Pixel_3a_API_34_extension_level_7_x86_64

adb shell
adb devices
