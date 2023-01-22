# MacOS

## double click to zoom
Apple icon > System Preferences > Dock > Select “Double-click a window’s title bar to” “Zoom” Shift + Double click on title bar to maximize the window.

## don't use smart quotes
Apple icon > System Preferences > Keyboard > Text tab >  Uncheck Use smart quotes and dashes



## Disable smart quotes:
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

## Disable smart dashes:
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

## Disable smart quotes for TextEdit:
defaults write com.apple.TextEdit SmartQuotes -bool false

## Disable smart dashes for TextEdit:
defaults write com.apple.TextEdit SmartDashes -bool false

## invert scroll wheel

defaults write -g com.apple.swipescrolldirection -bool FALSE (or TRUE)

Read the current value with: defaults read -g com.apple.swipescrolldirection.

## show hidden files
```
defaults write com.apple.finder AppleShowAllFiles YES
killall Finder
```

## dot directories on the finder
cmd-shift .

## swithces between screens within an app
cmd-tilda

## spotlight
cmd-space 

## put mission control in the upper left corner

## iterm2
cmd-d - split horizontal
cmd-shift-d - split virtical
cmd-option-f - password manager

## unmap capslock

## faster mouse
## hide dock

## enable remote
```
sudo systemsetup -setremotelogin on
```

## remove dictionary lookup
Open System Preferences > Keyboard > Shortcuts
Click Services in the left column 
In the Searching section, click the arrow to expand the options
Remove the checkmark from "Look Up in Dictionary"


## iterm2 fonts
profiles -> text -> font
