netsh interface ip set address name="Ethernet" static 192.168.10.55 255.255.255.0 192.168.10.1
netsh interface ip set dns name="Ethernet" static 8.8.8.8
netsh interface ip add dns name="Ethernet" 8.8.4.4 index=2
