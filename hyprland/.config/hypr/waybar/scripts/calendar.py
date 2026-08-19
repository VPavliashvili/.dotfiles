#!/usr/bin/env python

import subprocess
import json

cmd = ["hyprctl monitors -j"]
out = subprocess.getoutput(cmd)
monitors = json.loads(out)

focused = None
for monitor in monitors:
    if monitor["focused"]:
        focused = monitor
        break

if focused is None:
    raise Exception("could not find focused monitor")

# for more info about hyprland monitor rotation and its rules, refer to
# https://wiki.hyprland.org/Configuring/Monitors/#rotating
is_vertical = focused["transform"] % 2 == 1

x_axis = focused["height"] if is_vertical else focused["width"]
y_axis = focused["width"] if is_vertical else focused["height"]
x_axis = x_axis / focused["scale"]
y_axis = y_axis / focused["scale"]

width = 220
height = 220

posX = x_axis - width - 60
posY = y_axis - height - 30

cmd = [
    'pkill -f "yad --calendar --undecorated --no-buttons --width={} --height={}"'.format(
        width, height
    )
]
subprocess.getoutput(cmd)

cmd = [
    'hyprctl dispatch exec [move {} {}] "yad --calendar --undecorated --no-buttons --width={} --height={}"'.format(
        posX, posY, width, height
    )
]
subprocess.getoutput(cmd)
