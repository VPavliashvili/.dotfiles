#!/bin/sh

swaymsg -t get_tree | jq -r '.. | select(.pid?) | .pid' | xargs kill
sleep 1
# double check
swaymsg -t get_tree | jq -r '.. | select(.pid?) | .pid' | xargs -r kill -9

sleep 0.5

$HOME/bin/disconnectwork.sh
