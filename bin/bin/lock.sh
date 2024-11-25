#!/usr/bin/env bash

ICON=~/Pictures/icons/key-fancy.png
TMPBG=~/temp/lock.png
scrot ~/temp/lock.png
convert $TMPBG -scale 10% -scale 1000% $TMPBG
convert $TMPBG $ICON -gravity center -composite -matte $TMPBG

orange=E88E41
blue=55B4C0
green=12BF7B

i3lock -i $TMPBG --indicator --radius 120 --ring-width 15.0 --inside-color=00000000 --ring-color=$orange --keyhl-color=$blue --greeter-color=$green --greeter-text="Provide a Password" --wrong-text="" --noinput-text="" --verif-text="" --line-uses-ring --greeter-font='Roboto:style=Medium Italic' --keylayout 2 --layout-color=$green --layout-size=25 --layout-font='Hack Nerd Font Mono:style=Bold' --time-size=25 --time-pos=715:100 --time-color=$green --date-color=$green --date-size=18

rm ~/temp/lock.png
