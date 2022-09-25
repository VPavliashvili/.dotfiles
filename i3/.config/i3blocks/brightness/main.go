package main

import (
	"fmt"
	"math"
	"os/exec"
	"strconv"
	"strings"
)

func main() {
	args1 := []string{"get"}
	args2 := []string{"max"}
	command := "brightnessctl"

	curOutput, _ := exec.Command(command, args1...).Output()
    asString := string(curOutput[:])
    trimmed := strings.TrimSuffix(asString, "\n")
	current, _ := strconv.Atoi(trimmed)

	maxOutput, _ := exec.Command(command, args2...).Output()
    asString = string(maxOutput[:])
    trimmed = strings.TrimSuffix(asString, "\n")
    max, _ := strconv.Atoi(trimmed)

    //fmt.Printf("cur %v, max %v\n", current, max)

    percent := float32(current) / float32(max) * 100
    result := math.Ceil(float64(percent))

    fmt.Printf(" %v%%\n ", result)
}
