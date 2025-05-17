#!/bin/sh

swaymsg 'workspace --no-auto-back-and-forth 2'
swaymsg exec brave

sleep 2.5

swaymsg 'workspace --no-auto-back-and-forth 7'
swaymsg exec vesktop

sleep 4.0

swaymsg 'workspace --no-auto-back-and-forth 10'
swaymsg exec "foot -e btop"
swaymsg exec spotify

sleep 2

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
