#!/usr/bin/env python

import subprocess
import json

cmd = ["swaymsg -t get_outputs --raw"]
out = subprocess.getoutput(cmd)
monitors = json.loads(out)

focused = None
for monitor in monitors:
    if monitor["focused"]:
        focused = monitor
        break

if focused is None:
    raise Exception("could not find focused monitor")

# in sway 90 means vertical with orientation up, without flip
is_vertical = focused["transform"] == "90"

x_axis = (
    focused["current_mode"]["height"]
    if is_vertical
    else focused["current_mode"]["width"]
)
y_axis = (
    focused["current_mode"]["width"]
    if is_vertical
    else focused["current_mode"]["height"]
)

x_axis = x_axis / focused["scale"]
y_axis = y_axis / focused["scale"]

width = 220
height = 220

posX = x_axis - width - 90
posY = y_axis - height - 30

cmd = [
    'pkill -f "yad --calendar --undecorated --no-buttons --width={} --height={}"'.format(
        width, height
    )
]
subprocess.getoutput(cmd)

cmd = [
    'swaymsg exec "yad --calendar --undecorated --no-buttons --width={} --height={}" && sleep 0.1 && swaymsg "[app_id="yad"] move position {} {}"'.format(
        width, height, int(posX), int(posY)
    )
]
subprocess.getoutput(cmd)
