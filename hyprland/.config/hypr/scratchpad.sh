#!/usr/bin/env bash

log ()
{
    logfile="/tmp/hyprland_scratchpad.log"
    dt=$(date +'%F %T')
    echo $1
    printf "LOG -> TIME: $dt, MSG: $1\n" >> $logfile
}

# get special workspace name from second argument
SCRATCHPAD_WS="$2"

LAST_WINDOW_ADDRESS="" # last window inside special scratchpad container workspace
BASE_WORKSPACE="" # wokrspace name in which scrachpad window should appear from special scrathpad continer workspace

log "action name $1 on workspace: $SCRATCHPAD_WS"

if [[ "$1" == "push" ]]; then
    focused_window=$(hyprctl activewindow -j | jq -r '.address')

    # send focused window to special contianer workspace
    hyprctl dispatch movetoworkspacesilent $SCRATCHPAD_WS
elif [[ "$1" == "pull" ]]; then
    # else if inside pull branches is toggle(show/hide) for existing windows inside scratchpad container workspace
    if hyprctl clients -j | jq -e ".[] | select(.workspace.name == \"$SCRATCHPAD_WS\")" > /dev/null; then
        # this if flow shows the window from the scratchpad special ws

        scratchpad_address=$(hyprctl clients -j | jq -r "first(.[] | select(.workspace.name == \"$SCRATCHPAD_WS\") | .address)")

        log "scratchpad workspace named: $SCRATCHPAD_WS is not empty"

        BASE_WORKSPACE=$(hyprctl activeworkspace -j | jq '.id')

        log "base workspace id: $BASE_WORKSPACE"

        hyprctl dispatch movetoworkspacesilent "$BASE_WORKSPACE,address:$scratchpad_address"
        hyprctl dispatch focuswindow address:$scratchpad_address

        LAST_WINDOW_ADDRESS=$(hyprctl activewindow -j | jq -r '.address')
        log "window with pid: $LAST_WINDOW_ADDRESS pulled from scratchpad to workspace: $BASE_WORKSPACE"
    else
        log "scratchpad window with pid: $LAST_WINDOW_ADDRESS is active on $BASE_WORKSPACE and gonna hide it back to $SCRATCHPAD_WS"

        hyprctl dispatch focuswindow address:$LAST_WINDOW_ADDRESS
        hyprctl dispatch movetoworkspacesilent $SCRATCHPAD_WS

        log "window with pid: $LAST_WINDOW_ADDRESS pushed to scratchpad from workspace: $BASE_WORKSPACE"
    fi
else
    log "bad input, only argument should be either push or pull followed with target special workspace name"
fi

