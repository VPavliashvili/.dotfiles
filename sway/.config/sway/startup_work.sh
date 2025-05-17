#!/bin/sh

vm=false

# -v -> virtual machine for remote connection(if false remmina)
while getopts 'v' flag
do
    case "${flag}" in
        v) vm=true
    esac
done

swaymsg 'workspace --no-auto-back-and-forth 2'
swaymsg exec brave

sleep 2.5

swaymsg 'workspace --no-auto-back-and-forth 10'
swaymsg exec "foot -e btop"
swaymsg exec spotify

sleep 2

swaymsg 'workspace --no-auto-back-and-forth 7'
swaymsg exec "foot -e btop"
sleep 0.5
swaymsg exec "teams-for-linux"
swaymsg exec vesktop

sleep 4.0

swaymsg '[app_id="teams-for-linux"] focus, mark teams_container'
swaymsg "splith"
swaymsg "layout tabbed"
swaymsg '[app_id="vesktop"] move window to mark teams_container'
swaymsg 'unmark teams_container'

sleep 1.0

swaymsg 'workspace --no-auto-back-and-forth 1'
swaymsg exec "foot -e zellij attach main-terminal"

sleep 0.25

swaymsg exec "foot -e zellij attach scratchpad"

sleep 0.5

swaymsg floating toggle
swaymsg resize 'set width 1645 px height 955 px'
swaymsg 'move position 235 px 100 px'
swaymsg move scratchpad
swaymsg 'workspace --no-auto-back-and-forth 1'

sleep 1.5

if [ "$vm" = true ] ; then
    swaymsg exec '~/.config/sway/run_vm.sh -n win10_work -w 6 -f -a "-f /dev/shm/win10_work win:showFPS=yes -c 127.0.0.1 -p 5906"'
else
    swaymsg 'workspace --no-auto-back-and-forth 6'
    swaymsg exec "remmina"
    swaymsg exec "~/bin/connectwork.sh"
fi
