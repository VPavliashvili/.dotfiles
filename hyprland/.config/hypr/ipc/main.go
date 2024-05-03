package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"net"
	"os"
	"strings"
)

const (
	HOST = "127.0.0.1"
	PORT = "6001"
	TYPE = "tcp"
)

type event struct {
	Name string `json:"name"`
	Data string `json:"data"`
}

func main() {
	his := os.Getenv("HYPRLAND_INSTANCE_SIGNATURE")
	sock_file_path := fmt.Sprintf("/tmp/hypr/%s/.socket2.sock", his)
	c := make(chan event)

	// socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done

	go listenSocket(sock_file_path, c)
	// e := <-c
	// fmt.Printf("event: %s, data: %s", e.name, e.data)
	publishEvent(c)
}

func publishEvent(c chan event) {
	listen, err := net.Listen(TYPE, HOST+":"+PORT)
	if err != nil {
		fmt.Print(err)
		os.Exit(1)
	}
	// defer listen.Close()
	defer func() {
		println("defer close run")
		listen.Close()
	}()

	fmt.Printf("hyprland config eventListener tcp server started at %v\n", HOST+":"+PORT)

	for {
		conn, err := listen.Accept()
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
		println("for loop cycled")

		event := <-c
		serialized, err := json.Marshal(event)
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}

		conn.Write(serialized)

		fmt.Printf("hyrpland event published to %v -> name: %s, data: %s\n", HOST+":"+PORT, event.Name, event.Data)
	}
}

func listenSocket(socket string, c chan event) {
	conn, err := net.Dial("unix", socket)

	if err != nil {
		fmt.Printf("ERROR encountered, msg -> %s\n", err.Error())
		return
	}

	defer conn.Close()

	sigs := make(chan os.Signal, 1)
	// signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)

	go func() {
		scanner := bufio.NewScanner(conn)
		for scanner.Scan() {
			captured := scanner.Text()
			arr := strings.Split(captured, ">>")
			ev := event{
				Name: arr[0],
				Data: arr[1],
			}
			c <- ev
		}
		if err := scanner.Err(); err != nil {
			fmt.Printf("Error reading from socket: %v\n", err)
		}
	}()

	<-sigs
}
