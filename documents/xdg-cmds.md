 # xdg settings

 ## set the default browser
 xdg-settings set default-web-browser brave-browser.desktop

 ~/.config/mimeapps.list

/usr/share/applications
.local/share/applications

x-scheme-handler/http=brave-browser.desktop
x-scheme-handler/https=brave-browser.desktop


$ xdg-mime query filetype whatever.mp4
video/mp4
$ xdg-mime default vlc.desktop video/mp4

# check default browser
xdg-settings get default-web-browser
xdg-settings check default-web-browser brave-browser.desktop
