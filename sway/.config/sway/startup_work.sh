#!/bin/sh

swaymsg 'workspace --no-auto-back-and-forth 2'
swaymsg exec brave

sleep 2.5

swaymsg 'workspace --no-auto-back-and-forth 7'
swaymsg exec vesktop

sleep 3.5

swaymsg 'workspace --no-auto-back-and-forth 10'
swaymsg exec "foot -e btop"
swaymsg exec spotify

sleep 2

swaymsg 'workspace --no-auto-back-and-forth 1'
swaymsg exec "foot -e zellij attach main-terminal"

sleep 0.25

swaymsg exec "foot -e zellij attach scratchpad"

sleep 0.25

swaymsg move scratchpad
swaymsg 'workspace --no-auto-back-and-forth 1'

sleep 1.5

swaymsg exec '~/.config/sway/run_vm.sh -n win10_liberty_work -w 6 -f -a "-f /dev/shm/looking-glass-work win:showFPS=yes -c 127.0.0.1 -p 5906"'

sleep 1.5

swaymsg exec '~/.config/sway/run_vm.sh -n win10_teams -w 7 -a "-f /dev/shm/looking-glass-teams audio:micDefault=allow win:showFPS=yes -c 127.0.0.1 -p 5907"'
