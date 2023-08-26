#!/usr/bin/env python

import os
import signal
import socket
import subprocess
import json

def get_pavucontrol_open_status() -> tuple[bool, int]:
    HOST = '127.0.0.1'
    PORT = 6000
         
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((HOST, PORT))
         
    s.send("pavucontrol".encode("ascii"))

    resp = s.recv(1024)
    s = resp.decode()
    print("received from ipc -> " + s)

    data = json.loads(s)

    is_open = data["isOpen"]
    pid = data["pid"]
    return bool(is_open), pid

def click_pavucontrol():
    is_open, pid = get_pavucontrol_open_status()
    print(str(is_open) + ", pid -> " + str(pid) + "\n")
    if is_open:
        os.kill(pid, signal.SIGKILL)
        print("puvucontrol closed")
    else:
        subprocess.run(["pavucontrol"])
        print("pavucontrol opened")

click_pavucontrol()
