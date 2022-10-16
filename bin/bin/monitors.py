#!/usr/bin/python

from time import sleep
from subprocess import run

run(["xrandr", "--output", "eDP-1", "--mode", "2880x1800", "--output", "HDMI-1", "--mode", "1920x1080", "--primary", "--right-of", "eDP-1"])
sleep(1)
run(["xrandr", "--output", "HDMI-1", "--scale", "2x2"])
