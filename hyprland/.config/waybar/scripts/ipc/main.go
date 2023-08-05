package main

import (
	"bytes"
	"fmt"
	"net"
	"os"
	"strconv"
	"strings"
)

const (
	HOST = "127.0.0.1"
	PORT = "6000"
	TYPE = "tcp"
)

type message struct {
	body string
}

func main() {
	listen, err := net.Listen(TYPE, HOST+":"+PORT)
	if err != nil {
		fmt.Print(err)
		os.Exit(1)
	}
	defer listen.Close()

	var counter int

	fmt.Printf("tcp server started at %v\n", HOST+":"+PORT)
	for {
		conn, err := listen.Accept()
		if err != nil {
			fmt.Print(err)
			os.Exit(1)
		}
		ch := make(chan message)
		go getRequets(conn, ch)
		msg := <-ch

		switch msg.body {
		case "next_disk":
			counter++
			fmt.Printf("counter increase -> %v\n", counter)
		case "get_disk":
			resp := strconv.Itoa(counter)
			conn.Write([]byte(resp))
			fmt.Printf("counter returned -> %v\n", counter)
		default:
            msg := fmt.Sprintf("unhandled mesage received -> %v\n", msg.body)
			fmt.Print(msg)
			conn.Write([]byte(msg))
		}
        conn.Close()
	}
}

func getRequets(conn net.Conn, ch chan message) {
	buffer := make([]byte, 1024)
	_, err := conn.Read(buffer)
	if err != nil {
		fmt.Print(err)
	}

	// ascii 0 == null
	n := bytes.IndexByte(buffer, 0)
	body := string(buffer[:n])

	msg := message{
		body: strings.TrimSuffix(body, "\n"),
	}
	ch <- msg
}
