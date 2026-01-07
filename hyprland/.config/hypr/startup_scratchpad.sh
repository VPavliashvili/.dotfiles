#!/usr/bin/env bash


hyprctl dispatch exec "[workspace special:scratch; float; size 80% 85%] foot -e sessions scratchpad"

# 2. Give Hyprland time to create & focus the window
sleep 0.5

WIN_ADDR=$(hyprctl activewindow -j | jq -r '.address')

echo "{\"kind\": \"upd\", \"queue\": [\"$WIN_ADDR\"]}" | nc -U /tmp/hyprland_scratchpad/scratch.sock

hyprctl dispatch togglespecialworkspace scratch
