#!/bin/sh

hyprctl dispatch exec spotify
hyprctl dispatch exec "[workspace 10 silent]" "foot btop" 
hyprctl dispatch exec webcord
~/.config/hypr/run_vm.sh -n win10_liberty_work -g 1 -w 6 -a "-f /dev/shm/looking-glass-work -c 127.0.0.1 -p 5906" -f
~/.config/hypr/run_vm.sh -n win10_teams -g 1 -w 7 -a "-f /dev/shm/looking-glass-teams audio:micDefault=allow -c 127.0.0.1 -p 5907"
hyprctl dispatch exec brave
hyprctl dispatch exec "[workspace 1 silent]" "foot -e zellij attach main-terminal" 
