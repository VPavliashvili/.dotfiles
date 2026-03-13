#!/usr/bin/env bash


hyprctl dispatch exec "[workspace special:scratch; float; size (monitor_w*0.8) (monitor_h*0.85)] foot -e sessions scratchpad"

sleep 1.0

WIN_ADDR=$(hyprctl activewindow -j | jq -r '.address')

echo "{\"kind\": \"upd\", \"queue\": [\"$WIN_ADDR\"]}" | nc -U /tmp/hyprland_scratchpad/scratch.sock

hyprctl dispatch togglespecialworkspace scratch
