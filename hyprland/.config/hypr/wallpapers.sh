#!/usr/bin/env sh

# this script is relevant to hyrpaper prior to v0.8.0
# should change after the update

rate=5 # rate of refresh wallapeprs(default is 5)
unit=s # unit of time of refresh(default is seconds)

while getopts 'r:u:' flag
do
    case "${flag}" in
        r) rate="${OPTARG}" ;;
        u) unit="${OPTARG}" ;;
    esac
done

get_wallpaper() {
    local directory=$1

    active=$(hyprctl hyprpaper listactive)
    monitors_count=$(hyprctl monitors -j | jq 'length')

    if [[ $(echo "$active" | wc -l) != "no wallpapers active" && $(echo "$active" | wc -l) -eq $monitors_count ]]; then
        existing=$(echo "$active" | sed -n "s/.*$name = \([^ ]*\).*/\1/p")
        count=$(fd -e png -e jpg -e jpeg . $directory | wc -l)

        if [[ $count -gt 1 ]]; then
            fd -e png -e jpg -e jpeg . $directory | grep -vF $existing | shuf -n1
        else
            echo $existing
        fi
    else
        fd -e png -e jpg -e jpeg . $directory | shuf -n1
    fi
}

main() {

    hyprctl hyprpaper unload all

    hyprctl monitors -j | jq -r '.[] | "\(.name) \(.transform)"' | while IFS=' ' read -r name transform; do
        # echo "Monitor $name, transform $transform"

        local wallpaper=""
        if [[ $transform -eq 0 ]]; then
            wallpaper=$(get_wallpaper ~/.wallpapers/landscape)
        elif [[ $transform -eq 3 ]]; then
            wallpaper=$(get_wallpaper ~/.wallpapers/vertical)
        fi

        hyprctl hyprpaper preload $wallpaper
        hyprctl hyprpaper wallpaper "$name,$wallpaper"
    done

    sleep "$rate$unit"
    main
}

main
