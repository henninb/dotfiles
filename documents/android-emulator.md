openssl x509 -inform DER -in burp.der -out burp.pem
openssl x509 -inform PEM -subject_hash_old -in burp.pem | head -1
mv burp.pem <cert>.0

adb push <cert>.0 /sdcard/

adb root
adb remount
adb shell
mv /sdcard/<cert>.0 /system/etc/security/cacerts/
chmod 644 /system/etc/security/cacerts/<cert>.0


emulator -avd Nexus_6_API_27-2 -http-proxy 192.168.10.40:8080
emulator -avd Nexus_6_API_27-2 -http-proxy 192.168.10.41:8080
emulator -list-avds
emulator -avd Nexus_6_API_27
emulator -avd Pixel_3a_API_34_extension_level_7_x86_64

adb shell
adb devices


emulator -avd Nexus_6_API_27 -writable-system -http-proxy http://192.168.10.40:8080
adb root
adb remount


adb reboot
