#!/usr/bin/env sh

Xaxis=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
Yaxis=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)

height=220
width=220

posX="$(($Xaxis - $width - 60))"
posY="$(($Yaxis - $height - 30))"

echo $posX
echo $posY

pkill -f "yad --calendar --undecorated --no-buttons --width=$width --height=$height"
hyprctl dispatch exec [move $posX $posY] "yad --calendar --undecorated --no-buttons --width=$width --height=$height"
