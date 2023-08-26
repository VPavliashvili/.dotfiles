package main

import (
	"encoding/json"
	"fmt"
	"math"
	"os/exec"
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
	Fullscreen     bool     `json:"fullscreen"`
	FullscreenMode int      `json:"fullscreenMode"`
	FakeFullscreen bool     `json:"fakeFullscreen"`
	Grouped        []string `json:"grouped"`
	Swallowing     string   `json:"swallowing"`
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
		if client.Class == "pavucontrol" {
			return true, client.Pid
		}
	}

	return false, math.MinInt
}
