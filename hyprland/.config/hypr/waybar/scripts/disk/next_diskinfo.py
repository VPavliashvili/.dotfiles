#!/usr/bin/env python

import socket

# IPC parameters
HOST = '127.0.0.1' # The server's hostname or IP address
PORT = 6000 # The port used by the server

# Create socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((HOST, PORT))
 
# Send 'request'
data = 'next_disk'.encode("ascii")
s.sendall(data)
