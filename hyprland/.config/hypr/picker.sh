#!/usr/bin/env bash

operation=$1

is_gui() {
    local cmd
    cmd=$(command -v "${1%% *}")
    [[ -z "$cmd" ]] && return 1
    ldd "$cmd" 2>/dev/null | grep -qE 'libgtk|libQt|libqt|libxcb|libwayland-client|libSDL|libGL'
}

if [[ $operation == "options" ]]; then
    declare -A items 
    items["emojis"]="bemoji -n"
    items["work layout"]="~/.config/hypr/run_work_layout.sh"
    items["home layout"]="~/.config/hypr/run_home_layout.sh"

    choice=$(printf '%s\n' "${!items[@]}" | fuzzel -b 282c34ff -t 61afefff -s 98c379ff -m c678ddff -S 000000ff -f SourceCodePro:size=12 -i -w 90 -l 25 --dmenu)

    ${items[$choice]}
elif [[ $operation == "muter" ]]; then
    choice=$(pactl --format=json list sink-inputs | jq -r '.[] | (.properties."media.name" | if . == "(null)" then null else . end) // .properties."application.name" as $name | "\(.index) [\(if .mute then "muted" else "unmuted" end)] \($name)"' | fuzzel -b 282c34ff -t 61afefff -s 98c379ff -m c678ddff -S 000000ff -f SourceCodePro:size=12 -i -w 90 -l 25 --dmenu)

    index=$(echo "$choice" | awk '{print $1}')
    pactl set-sink-input-mute "$index" toggle
elif [[ $operation == "runhst" ]]; then
    HISTFILE=~/.bash_history
    FZL="fuzzel -b 282c34ff -t 61afefff -s 98c379ff -m c678ddff -S 000000ff -f SourceCodePro:size=12 -i -w 90 -l 25 --dmenu"
    chosen=$(history -r && history | awk '{$1=""; print substr($0,2)}' | tac | awk '!seen[$0]++' | $FZL)
    if [[ -n $chosen ]]; then
        yad --text="$chosen" --button="Copy:0" --button="Run:1" --css=<(echo "button:focus, button:focus label { background-color: #98c379 !important; color: #ffffff !important; }")

        case "$?" in
            0) 
                # notify-send "chosen copy: $chosen" 
                echo "$chosen" | wl-copy
                ;;
            1) 
                first_word="${chosen%% *}"
                if is_gui "$first_word"; then
                    # notify-send "$chosen is a gui app"
                    bash -c "$chosen &"
                else
                    # notify-send "$chosen is a cli app"
                    cmd="$chosen"
                    hyprctl dispatch exec "[float; size (monitor_w*0.7) (monitor_h*0.7); center] foot bash -c '$cmd'"
                fi

                # also update the history
                # and move chosen command at the top
                echo "$chosen" >> ~/.bash_history
                ;;
            *) ;;
        esac
    fi
    
fi
