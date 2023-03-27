 # xdg settings
 
 ## set the default browser
 xdg-settings set default-web-browser surf.desktop
 xdg-settings set default-web-browser iceweasel.desktop
 
 ~/.config/mimeapps.list
 
/usr/share/applications
.local/share/applications

x-scheme-handler/http=google-chrome.desktop
x-scheme-handler/https=google-chrome.desktop


$ xdg-mime query filetype whatever.mp4
video/mp4
$ xdg-mime default vlc.desktop video/mp4
