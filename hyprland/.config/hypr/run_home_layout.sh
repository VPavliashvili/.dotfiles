#!/bin/sh

hyprctl dispatch exec "[workspace 10 silent]" "foot btop" 
hyprctl dispatch exec spotify
hyprctl dispatch exec webcord
hyprctl dispatch exec brave
hyprctl dispatch exec "[workspace 1 silent]" "foot -e zellij attach main-terminal" 
