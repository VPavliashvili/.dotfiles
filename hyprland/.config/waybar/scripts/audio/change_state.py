#!/usr/bin/env python

import socket
import json

def mute():
    HOST = '127.0.0.1'
    PORT = 6000
         
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((HOST, PORT))
         
    s.send("mic_mute".encode("ascii"))

    resp = s.recv(1024)
    s = resp.decode()
    print("received from ipc -> " + s)

mute()
