#!/bin/sh

date=$(date '+%Y-%m-%d')
Font='Noto-Sans-Display-Bold'
FontSize=200
Text=$1
TextColor='#FFFFFF'
#Resize='50%'
Original="$HOME/.local/share/myimages/thumbnail.jpg"
Output="$HOME/Desktop/output-${date}.jpg"

Err(){
	printf 'ERROR: %s\n' "$2" 1>&2
	[ $1 -gt 0 ] && exit $1
}

[ $# -ne 1 ] && Err 1 'Thumbnail annotation string required.'

if [ -x "$(command -v convert)" ]; then
  echo "need to install an app"
  exit 1
fi

if [ -x "$(command -v feh)" ]; then
  echo "please install feh and try to run the script again."
  exit 1
fi

# command -v convert 1> /dev/null 2>&1 || Err 1 "Dependency 'convert' not met."
# command -v feh 1> /dev/null 2>&1 || Err 1 "Dependency 'feh' not met."

# I know these can be combined, but I'm finding it easier to split them up.
if ! convert "$Original" -auto-level -background '#000000' -vignette 0x120+-60-60 -quality 100 "$Output"; then
  echo "convert failed."
  exit 1
fi

[ $? -eq 0 ] && Err=$((Err + $?))

convert "$Output" -fill "$TextColor" -strokewidth 4 -stroke Black\
	-pointsize "$FontSize" -font "$Font" -gravity Center -annotate +0 "$Text"\
	-quality 100 "$Output"

[ $? -eq 0 ] && Err=$((Err + $?))

#convert "$Output" -resize "$Resize" -quality 100 "$Output"

#[ $? -eq 0 ] && Err=$((Err + $?))

# If '0', then no errors occurred, so display image.
[ $Err -eq 0 ] && feh "$Output"
