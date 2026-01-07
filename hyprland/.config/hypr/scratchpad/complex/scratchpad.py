#!/usr/bin/env python

import argparse
from ast import Try
import json
import sys
import subprocess
import os
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent.parent))

from complex.common import Logger, Message, CommChannel

parser = argparse.ArgumentParser(
    description="Sway like scratchpad in hyprland",
    exit_on_error=True,
    epilog="Info: this script is written against Hyprland 0.52.1",
)

_ = parser.add_argument(
    "-a",
    "--action",
    type=str,
    choices=["push", "pull"],
    required=True,
    help="Action to choose pull from scratchpad or push(i.e. add new show window from scratchpad container or add new window to it). note: this argument is required",
)
_ = parser.add_argument(
    "-c",
    "--container",
    type=str,
    required=True,
    help="Name of the container special workspace from hyprland(i.e. special:scratch). note: this argument is required",
)
_ = parser.add_argument(
    "--log", action="store_true", help="Enables logging. Default value is False"
)
args = parser.parse_args()

logger = Logger(args.container, args.log)

SCRATCHPAD_CONTAINER_WS = args.container
ACTION = args.action


channel = CommChannel(SCRATCHPAD_CONTAINER_WS)

# logger.log("TRACE", f"channel initialized at {channel.socketPath}")

if not os.path.exists(channel.socketPath):
    logger.log(
        "ERROR",
        f"Socket was closed at {channel.socketPath}, probably daemon.py is not running",
    )
    sys.exit(1)

# logger.log("TRACE", f"channel created at {channel.socketPath}")


def getQueueFromDaemon():
    sock = channel.getConnectedSocket()

    cmd_dict = {"kind": "get"}

    cmd = json.dumps(cmd_dict).encode()
    logger.log("TRACE", f"cmd sent to daemon: {cmd}")

    sock.sendall(cmd)
    queue = json.loads(sock.recv(8192).decode())

    logger.log("TRACE", f"queue received from daemon: {queue}")

    return queue


def exec_cmd(cmd_lst):
    try:
        res = subprocess.run(
            cmd_lst,
            capture_output=True,
            text=True,
            check=True,
        )
        raw = res.stdout

        # logger.log(
        #     "TRACE",
        #     f"hyprctl command executed: {repr(cmd_lst)}, output: {raw}",
        # )

        return raw
    except subprocess.CalledProcessError as e:
        logger.log(
            "ERROR",
            f"hyprctl command: {repr(cmd_lst)} was invalid, code: {e.returncode}, stdout: {e.stdout}, stderr: {e.stderr}",
        )
        sys.exit(0)


def hyprctl_cmd(command_txt: str):
    splits = command_txt.split(" ")
    cmd_lst = ["hyprctl"] + splits
    return exec_cmd(cmd_lst)


def hyprctl_dispatch(dispatch_action: str):
    splits = dispatch_action.split(" ")
    cmd_lst = ["hyprctl", "dispatch"] + splits
    return exec_cmd(cmd_lst)


special_ws_name = (
    SCRATCHPAD_CONTAINER_WS
    if SCRATCHPAD_CONTAINER_WS.startswith("special:")
    else f"special:{SCRATCHPAD_CONTAINER_WS}"
)

try:
    if ACTION == "push":
        # if no window is focused(e.g. standing in a empty workspace) then ignore this command
        # get currently focused hyprland window info
        raw = hyprctl_cmd("activewindow -j")

        # this might happen when standing on the empty workspace
        # or something like that scenario when running hyprland and not focused on any window
        if raw is None or raw.strip() == "[]" or raw.strip() == "{}":
            logger.log("TRACE", "there was no focused window... exiting program...")
            sys.exit(0)

        focused_window = json.loads(raw)
        focused_window_addr = focused_window["address"]

        logger.log(
            "TRACE",
            f"hyprland windows address send to scratchpad is: {focused_window_addr}",
        )

        if not focused_window["floating"]:
            _ = hyprctl_dispatch("togglefloating")

            _ = hyprctl_dispatch("resizeactive exact 80% 80%")

            _ = hyprctl_dispatch("centerwindow")

        _ = hyprctl_dispatch(f"movetoworkspacesilent {special_ws_name}")

        queue = getQueueFromDaemon()

        if focused_window_addr not in queue:
            # if window already was not parth of the scratchpad container
            # add it into underlying queue data structure and update the daemon data

            queue.append(focused_window_addr)

            cmd_dict = {"kind": "upd", "queue": queue}

            cmd = json.dumps(cmd_dict).encode()
            logger.log("TRACE", f"upd cmd sent to daemon: {cmd}")

            sock = channel.getConnectedSocket()
            sock.sendall(cmd)

    # this automatically means action == pull, otherwise parse_args would have thrown an error
    else:
        queue = getQueueFromDaemon()

        if not bool(queue):
            logger.log("TRACE", f"no windows in {SCRATCHPAD_CONTAINER_WS} scratchpad")
            sys.exit(0)

        raw = hyprctl_cmd("activewindow -j")
        focused_window_exists = (
            (raw is not None) and (raw.strip() != "[]") and (raw.strip() != "{}")
        )

        logger.log("DEBUG", f"focused exists: {focused_window_exists}")

        if focused_window_exists:
            focused_window = json.loads(raw)
            focused_window_addr = focused_window["address"]

            logger.log("DEBUG", f"queue: {repr(queue)}")

            # checks if focused window is already
            # pulled but still part of the scratchpad
            # if this is true then it we should hide this
            # window back to scrachpad instead showing it
            if focused_window_addr in queue:
                logger.log(
                    "TRACE",
                    f"focused window {focused_window_addr} is already pulled and unhidden, so hiding back to special workspace {special_ws_name}",
                )
                _ = hyprctl_dispatch(
                    f"movetoworkspacesilent {special_ws_name},address:{focused_window_addr}"
                )

                queue.remove(focused_window_addr)
                queue.append(focused_window_addr)

                cmd_dict = {"kind": "upd", "queue": queue}

                cmd = json.dumps(cmd_dict).encode()

                sock = channel.getConnectedSocket()
                sock.sendall(cmd)
            else:
                next_window_address = queue[0]

                raw = hyprctl_cmd("activeworkspace -j")
                active_workspace = json.loads(raw)
                active_ws_name = active_workspace["name"]

                _ = hyprctl_dispatch(
                    f"movetoworkspacesilent {active_ws_name},address:{next_window_address}"
                )
                _ = hyprctl_dispatch(f"focuswindow address:{next_window_address}")

        else:
            next_window_address = queue[0]

            raw = hyprctl_cmd("activeworkspace -j")
            active_workspace = json.loads(raw)
            active_ws_name = active_workspace["name"]

            _ = hyprctl_dispatch(
                f"movetoworkspacesilent {active_ws_name},address:{next_window_address}"
            )
            _ = hyprctl_dispatch(f"focuswindow address:{next_window_address}")

except Exception as e:
    logger.log("ERROR", f"exception thrown from {args.action} action: {repr(e)}")
    sys.exit(1)
