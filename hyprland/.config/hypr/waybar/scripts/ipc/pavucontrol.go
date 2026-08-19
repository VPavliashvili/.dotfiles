package main

import (
	"encoding/json"
	"fmt"
	"math"
	"os/exec"
	"strings"
)

// hyprland client aka hyprctl clients -j
type client struct {
	Address   string `json:"address"`
	Mapped    bool   `json:"mapped"`
	Hidden    bool   `json:"hidden"`
	At        []int  `json:"at"`
	Size      []int  `json:"Size"`
	Workspace struct {
		Id   int    `json:"id"`
		Name string `json:"name"`
	} `json:"workspace"`
	Floating       bool     `json:"floating"`
	Monitor        int      `json:"monitor"`
	Class          string   `json:"class"`
	Title          string   `json:"title"`
	InitialClass   string   `json:"initialClass"`
	InitialTitle   string   `json:"initialTitle"`
	Pid            int      `json:"pid"`
	Xwayland       bool     `json:"xwayland"`
	Pinned         bool     `json:"pinned"`
	Fullscreen     int      `json:"fullscreen"`
}

func getHyprlandClients() []client {
	cmd := exec.Command("hyprctl", "clients", "-j")
	output, err := cmd.Output()
	if err != nil {
		fmt.Println(err)
		return nil
	}

	var clients []client
	err = json.Unmarshal([]byte(output), &clients)
	if err != nil {
		fmt.Println(err)
		return nil
	}

	return clients
}

func pavuInfo() (bool, int) {

	clients := getHyprlandClients()
	for _, client := range clients {
		class := strings.ToLower(client.Class)
		if strings.Contains(class, "pavucontrol") {
			return true, client.Pid
		}
	}

	return false, math.MinInt
}

type pactlMicInfo struct {
	Name   string `json:"name"`
	Mute   bool   `json:"mute"`
	Volume struct {
		Data struct {
			Value         int    `json:"value"`
			Value_percent string `json:"value_percent"`
			Db            string `json:"db"`
		} `json:"front-left"`
	} `json:"volume"`
}

func micInfo() (isMuted bool, volume string) {
	source_name, err := defaultMicName()
	if err != nil {
		fmt.Println(err)
		return isMuted, volume
	}
	fmt.Printf("default source name -> %v\n", string(source_name))

	cmd := exec.Command("pactl", "-f", "json", "list", "sources")
	output, err := cmd.Output()
	if err != nil {
		fmt.Println(err)
		return isMuted, volume
	}

	var sources []pactlMicInfo
	err = json.Unmarshal(output, &sources)
	if err != nil {
		fmt.Println(err)
		return isMuted, volume
	}
	fmt.Println("deserialized objects")
	fmt.Println(sources)

	for _, source := range sources {
		fmt.Printf("%v <-> %v => %v\n", string(source_name), source.Name, string(source_name) == source.Name)
		if source.Name == string(source_name) {
			isMuted = source.Mute
			volume = source.Volume.Data.Value_percent
		}
	}

	fmt.Println("entered the last line")
	return isMuted, volume
}

func defaultMicName() (string, error) {
	cmd := exec.Command("pactl", "get-default-source")
	source_name_buffer, err := cmd.Output()
	if err != nil {
		fmt.Println(err)
		return "", err
	}
	source_name := string(source_name_buffer)
	source_name = strings.TrimSuffix(source_name, "\n")

	return source_name, nil
}
