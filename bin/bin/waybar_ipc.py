#!/usr/bin/env python

import socket
 
# IPC parameters
HOST = '127.0.0.1' # Standard loopback interface address (localhost)
PORT = 6000 # Port to listen on (non-privileged ports are > 1023)
ENCODING = 'ascii'
 
# Create socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(10)
 
counter = 0

# Start listening loop
while True:
    # Accept 'request'
    conn, addr = s.accept()
    print('Connected by', addr)
    # Process 'request'
    while True:
        data = conn.recv(1024)
        if data is None or not data:
            print("data was null")
            break

        msg = data.decode(ENCODING)

        if msg == 'next_disk':
            counter = counter + 1
            print("counter increase -> %s" % counter)
        elif msg == 'get_disk':
            conn.sendall(str(counter).encode(ENCODING))
            print("counter returned -> %s" % counter)

        break
