#!/usr/bin/env bash

# try to delete previous screen if exist
rm ~/temp/lock.png

flameshot full -p ~/temp/lock.png

icon="$HOME/Pictures/icons/password.png"
tmpbg="$HOME/temp/lock.png"

(( $# )) && { icon=$1; }

scrot "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
i3lock -u -i "$tmpbg"
