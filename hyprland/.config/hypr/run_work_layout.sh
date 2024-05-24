#!/bin/sh

hyprctl dispatch exec "[workspace 10 silent]" "foot btop" 
hyprctl dispatch exec spotify
hyprctl dispatch exec webcord
hyprctl dispatch exec -- ~/.config/hypr/run_vm.sh -n linux_teams -g -w 7 -k --
hyprctl dispatch exec -- ~/.config/hypr/run_vm.sh -n linux_remmina -g -w 6 -f --
hyprctl dispatch exec brave
hyprctl dispatch exec "[workspace 1 silent]" "foot -e zellij attach main-terminal" 
