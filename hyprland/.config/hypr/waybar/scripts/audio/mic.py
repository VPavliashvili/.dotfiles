#!/usr/bin/env python

import socket
import json

class Data:
    def __init__(self, text: str):
        self.text = text


def get_mic_status() -> tuple[bool, str]:
    HOST = '127.0.0.1'
    PORT = 6000
         
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((HOST, PORT))
         
    s.send("mic".encode("ascii"))

    resp = s.recv(1024)
    s = resp.decode()
    # print("received from ipc -> " + s)

    data = json.loads(s)

    isMuted = data["isMuted"]
    volume = data["volume"]
    return bool(isMuted), volume

def draw():
    ismuted, volume = get_mic_status()

    format_normal = "%s " % volume
    format_muted = ""
    format = format_muted if ismuted else format_normal

    data = Data(format)

    jsn = json.dumps(data.__dict__)
    print(jsn)

draw()
