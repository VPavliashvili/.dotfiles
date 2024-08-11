#!/bin/sh

swaymsg 'workspace --no-auto-back-and-forth 2'
swaymsg exec brave

sleep 3

swaymsg 'workspace --no-auto-back-and-forth 7'
swaymsg exec webcord

sleep 2

swaymsg 'workspace --no-auto-back-and-forth 10'
swaymsg exec "foot -e btop"
swaymsg exec spotify

sleep 2

swaymsg 'workspace --no-auto-back-and-forth 1'
swaymsg exec "foot -e zellij attach main-terminal"
