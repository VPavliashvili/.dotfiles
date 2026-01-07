from datetime import datetime
import os
import socket
import subprocess
import sys
from pathlib import Path


ROOT_PATH = "/tmp/hyprland_scratchpad/"


class HyprlandWindow:
    def __init__(
        self, address: str, already_in_scratchpad: bool, scratchpad_ws_name: str
    ):
        self.address: str = address
        self.already_in_scratchpad: bool = already_in_scratchpad
        self.scratchpad_ws_name: str = scratchpad_ws_name


class Message:
    def __init__(
        self,
        action: str,
        scratchpad_type: str,
        container_workspace: str,
        hyprland_windows: list[HyprlandWindow],
    ):
        self.action: str = action  # this is a string
        self.scratchpad_type: str = scratchpad_type  # this is a string
        self.container_workspace: str = container_workspace  # this is a string

        # this is a queue of hyprland windows
        self.hyprland_windows: list[HyprlandWindow] = hyprland_windows


class Logger:
    def __init__(self, container_workspace_name: str, enabled: bool):
        self.logDir: str = f"{ROOT_PATH}{container_workspace_name}"
        print(self.logDir)
        self.enabled: bool = enabled

    def log(self, lvl: str, msg: str):
        logmsg = f"{lvl} -> TIME: {datetime.now()}, MSG: {msg}"
        print(logmsg)

        if not self.enabled:
            return

        if not os.path.exists(self.logDir):
            os.makedirs(ROOT_PATH, exist_ok=True)

        logfile = f"{self.logDir}.log"
        with open(logfile, "a") as f:
            _ = f.write(logmsg)
            _ = f.write("\n")


class CommChannel:
    def __init__(self, daemonName: str) -> None:
        self.daemonName: str = daemonName
        self.basePath: str = f"{ROOT_PATH}{daemonName}"
        self.socketPath: str = f"{self.basePath}.sock"

    def getSocket(self):
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

        return sock

    # for client use
    def getConnectedSocket(self):
        sock = self.getSocket()
        sock.connect(self.socketPath)

        return sock
