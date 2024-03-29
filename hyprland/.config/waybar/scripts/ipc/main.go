package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net"
	"os"
	"os/exec"
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
		case "pavucontrol":
			isOpen, pid := pavuInfo()
			data := struct {
				IsOpen bool `json:"isOpen"`
				Pid    int  `json:"pid"`
			}{
				IsOpen: isOpen,
				Pid:    pid,
			}
			resp, err := json.Marshal(data)
			if err != nil {
				fmt.Println(err)
				continue
			}

			conn.Write(resp)
			fmt.Printf("pavucontrol received. Open status -> %v\n", string(resp))
		case "mic":
			resp, err := mic()
			if err != nil {
				fmt.Println(err)
				continue
			}
			conn.Write(resp)
			fmt.Printf("mic received. responded with -> %v\n", string(resp))
		case "mic_mute":
			_, err := mic()
			if err != nil {
				fmt.Println(err)
				continue
			}

			resp, err := mute_mic()
			if err != nil {
				fmt.Println(err)
				continue
			}

			conn.Write([]byte(resp))
			fmt.Printf("mic_mute received. responded with -> %v\n", resp)
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

// when "mic" ipc request is incoming
func mic() ([]byte, error) {
	isMuted, volume := micInfo()
	data := struct {
		IsMuted bool   `json:"isMuted"`
		Volume  string `json:"volume"`
	}{
		IsMuted: isMuted,
		Volume:  volume,
	}
	resp, err := json.Marshal(data)
	if err != nil {
		return nil, err
	}

	return resp, nil
}

// when "mic_mute" ipc request is incoming
func mute_mic() (string, error) {
	isMuted, _ := micInfo()
	name, err := defaultMicName()
	if err != nil {
		return "", err
	}

	if isMuted {
		//unmute
		cmd := exec.Command("pactl", "set-source-mute", name, "0")

		_, err = cmd.Output()
		if err != nil {
			return "", err
		}

		return "unmuted successfully", nil
	}

	// mute
	cmd := exec.Command("pactl", "set-source-mute", name, "1")
	_, err = cmd.Output()
	if err != nil {
		return "", err
	}
	return "muted successfully", nil
}
