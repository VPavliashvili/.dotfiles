#!/usr/bin/env sh

pkill -f 'yad --calendar --undecorated --no-buttons'
hyprctl dispatch exec [move 85% 80.1%] "yad --calendar --undecorated --no-buttons"
