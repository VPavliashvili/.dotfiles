#!/bin/sh

vm=false

# -v -> virtual machine for remote connection(if false remmina)
while getopts 'v' flag
do
    case "${flag}" in
        v) vm=true
    esac
done

hyprctl dispatch exec "[workspace 10 silent]" "spotify"
if [ "$vm" = true ] ; then
    ~/.config/hypr/run_vm.sh -n win10_work -g 1 -w 6 -a "-f /dev/shm/win10_work -c 127.0.0.1 -p 5906" -f
else
    hyprctl dispatch exec "[workspace 6 silent]" "foot -e ~/bin/connectwork.sh"
    hyprctl dispatch exec "[workspace 6 silent]" "remmina"
fi
hyprctl dispatch exec "[workspace 7 silent]" "foot btop" 
hyprctl dispatch exec "[workspace 7 silent]" "teams-for-linux" 
hyprctl dispatch exec "[workspace 2 silent]" "brave"
hyprctl dispatch exec "[workspace 1 silent]" "foot -e zellij attach main-terminal" 
