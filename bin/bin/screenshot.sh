#!/usr/bin/env bash


## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Screenshot (Ported to use Grimblast)

## Modify
## Author  : Gonçalo Duarte (MrDuartePT)
## Github  : @MrDuartePT

## Port for Grimblast (https://github.com/hyprwm/contrib/tree/main/grimblast)
## Aur Package: grimblast-git (https://aur.archlinux.org/packages/grimblast-git)

## Add this to the ~/.config/user-dirs.dirs to save in the Screenshots folder: XDG_SCREENSHOTS_DIR="$HOME/Screenshots"

## further modified by me, to avoid unnecessary timer option

option_capture_3="󱣴 Capture Area"

list_col='1'
list_row='1'
win_width='300px'

copy=' Copy'
save=' Save'
copy_save='Copy & Save'
edit='Edit Screenshot'

####
# Choose to save or copy photo
# CMD
copy_save_editor_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 400px;}' \
    -theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 2;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Choose Option' \
    -mesg 'Take a screenshot'
}

# Ask for confirmation
copy_save_editor_exit() {
  echo -e "$copy\n$save\n$copy_save\n$edit" | copy_save_editor_cmd
}

# Confirm and execute
copy_save_editor_run() {
  selected_chosen="$(copy_save_editor_exit)"
  if [[ "$selected_chosen" == "$copy" ]]; then
    option_chosen=copy
    ${1}
  elif [[ "$selected_chosen" == "$save" ]]; then
    option_chosen=save
    ${1}
  elif [[ "$selected_chosen" == "$copy_save" ]]; then
    option_chosen=copysave
    ${1}
  elif [[ "$selected_chosen" == "$edit" ]]; then
    option_chosen=edit
    ${1}
  fi
}
###

# take shots
takescreenshot() {
    grimblast --notify "$option_chosen" "$option_type_screenshot"
}

# Execute Command
run_cmd() {
    option_type_screenshot=area
    copy_save_editor_run "takescreenshot"
}

run_cmd 
