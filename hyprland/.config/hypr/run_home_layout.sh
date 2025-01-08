#!/bin/sh

hyprctl dispatch exec "[workspace 10 silent]" "foot btop" 
hyprctl dispatch exec "[workspace 10 silent]" "spotify"
hyprctl dispatch exec "[workspace 2 silent]"  "brave"
hyprctl dispatch exec "[workspace 1 silent]" "foot -e zellij attach main-terminal" 
