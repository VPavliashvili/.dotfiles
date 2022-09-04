#!/bin/bash

ICON=~/Pictures/icons/key-fancy.png
TMPBG=~/temp/lock.png
scrot ~/temp/lock.png
convert $TMPBG -scale 10% -scale 1000% $TMPBG
convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock -i $TMPBG --indicator --radius 120 --ring-width 15.0 --inside-color=00000000 --ring-color=E88E41 --keyhl-color=55B4C0 --greeter-color=92BF7B --greeter-text="Provide a Password" --wrong-text="" --noinput-text="" --verif-text="" --line-uses-ring  --greeter-font='Roboto:style=Medium Italic'
rm ~/temp/lock.png
