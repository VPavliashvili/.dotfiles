#!/usr/bin/env python

import argparse
import json
import os
import sys
import socket
import select
from pathlib import Path

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from complex.common import Logger, Message, CommChannel
import complex.common

parser = argparse.ArgumentParser(
    description="Daemon for scratchpad implementation script",
    exit_on_error=True,
)

_ = parser.add_argument(
    "-n",
    "--name",
    type=str,
    required=True,
    help="Name of the daemon process. Should be same as the name of hyprland special workspace used as a scratchpad container. Which is specified from scratchpad.py --container parameter",
)
_ = parser.add_argument(
    "--log",
    action="store_true",
    help="Enable logging",
)

args = parser.parse_args()

channel = CommChannel(args.name)

container_queue = []

# before doing anything
# make base dir if not exist
if not os.path.exists(complex.common.ROOT_PATH):
    os.makedirs(complex.common.ROOT_PATH, exist_ok=True)

logger = Logger(args.name, args.log)

logger.log("TRACE", f"starting daemon for: {channel.socketPath}")

# remove if old socket file exists for some reason(after reboot or something)
if os.path.exists(channel.socketPath):
    os.remove(channel.socketPath)

sock = channel.getSocket()
sock.bind(channel.socketPath)
sock.listen()

logger.log("TRACE", f"daemon started for: {channel.socketPath}, pid: {os.getpid()}")

# Connect to Hyprland event socket
hypr_instance = os.environ.get("HYPRLAND_INSTANCE_SIGNATURE")
runtime_dir = os.environ.get("XDG_RUNTIME_DIR", "/run/user/1000")
hypr_socket_path = f"{runtime_dir}/hypr/{hypr_instance}/.socket2.sock"

hypr_sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
hypr_sock.connect(hypr_socket_path)

logger.log("TRACE", f"connected to Hyprland event socket: {hypr_socket_path}")

# this list will collect active socket client connections
client_connections = []

try:
    while True:
        # build list of sockets to monitor
        readable_sockets = [sock, hypr_sock] + client_connections

        # wait for activity on any socket
        readable, _, _ = select.select(readable_sockets, [], [])

        for ready_sock in readable:
            # new client connection on control socket
            if ready_sock is sock:
                conn, _ = sock.accept()
                client_connections.append(conn)
                logger.log("TRACE", "new client connected")

            # event from Hyprland
            elif ready_sock is hypr_sock:
                try:
                    data = hypr_sock.recv(8192).decode()
                    if not data:
                        logger.log("ERROR", "Hyprland socket closed")
                        break

                    # hyprland events come as text lines like:
                    # closewindow>>0x5652e2784270
                    # changefloatingmode>>5652e2bd15c0,0
                    events = data.strip().split("\n")
                    for event in events:
                        if event:
                            if not event.startswith(
                                "changefloatingmode"
                            ) and not event.startswith("closewindow"):
                                continue

                            logger.log("TRACE", f"Hyprland event: {event}")
                            window_address = None

                            if event.startswith("changefloatingmode"):
                                logger.log("TRACE", "changefloatingmode event raised")
                                value = event.strip().split(">>")[1]
                                spl = value.strip().split(",")
                                floating_state_set_to = spl[1]

                                # this means if a window left floating mode
                                # then it should leave the scratchpad container
                                # this mimics i3/sway behaviour
                                if int(floating_state_set_to) == 0:
                                    window_address = spl[0]

                            elif event.startswith("closewindow"):
                                logger.log(
                                    "TRACE",
                                    f"closewindow event raised -> {repr(event.strip().split('>>'))}",
                                )
                                window_address = event.strip().split(">>")[1]
                                logger.log(
                                    "TRACE",
                                    f"window_address to remove: {window_address}",
                                )

                            # this line adds 0x to the start of the window address
                            # because hyprland ipc events return windwo addresses without 0x
                            # and normal hyprctl commands returns them with 0x
                            # e.g. `closewindow` event output is this: closewindow>>5652e2dd42e0
                            # and address filed value in `hyprctl activewindow -j`
                            # is this: "address": "0x5652e2a3fad0", adding 0x
                            # makes string comparisson possible
                            window_address = f"0x{window_address}"

                            logger.log(
                                "TRACE",
                                f"window_address to remove2: {window_address}",
                            )
                            if (
                                window_address is not None
                                and window_address in container_queue
                            ):
                                logger.log(
                                    "DEBUG",
                                    f"widnow removal event raised, even: {event}, window address: {window_address}",
                                )

                                logger.log("DEBUG", f"before: {repr(container_queue)}")
                                _ = container_queue.remove(window_address)
                                logger.log("DEBUG", f"after: {repr(container_queue)}")

                except Exception as e:
                    logger.log("ERROR", f"error reading Hyprland event: {e}")

            # data from client connection
            else:
                try:
                    raw_bytes = ready_sock.recv(8192)
                    if not raw_bytes:
                        # client disconnected
                        client_connections.remove(ready_sock)
                        ready_sock.close()
                        logger.log("TRACE", "client disconnected")
                        continue

                    dict_data = json.loads(raw_bytes)
                    logger.log("TRACE", f"msg received: {dict_data}")

                    if dict_data["kind"] == "get":
                        resp = json.dumps(container_queue).encode()
                        ready_sock.sendall(resp)
                        logger.log("TRACE", f"response sent to client: {resp}")

                    elif dict_data["kind"] == "upd":
                        container_queue = dict_data["queue"]
                        logger.log(
                            "TRACE",
                            f"container queue after upd: {repr(container_queue)}",
                        )

                    # close after handling
                    client_connections.remove(ready_sock)
                    ready_sock.close()

                except Exception as e:
                    logger.log("ERROR", f"error handling client: {e}")
                    if ready_sock in client_connections:
                        client_connections.remove(ready_sock)
                    ready_sock.close()

finally:
    sock.close()
    hypr_sock.close()
    for conn in client_connections:
        conn.close()
    os.remove(channel.socketPath)
