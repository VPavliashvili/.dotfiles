#!/usr/bin/env sh

operation=$1

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
fi
