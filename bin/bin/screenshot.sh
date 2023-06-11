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

prompt='Screenshot'
mesg="DIR: ~/Screenshots"

# Options
option_1="󰹑 Capture"

option_capture_1="󰍺 All Screen"
option_capture_2="󰍹 Capture Active Screen"
option_capture_3="󱣴 Capture Area"

list_col='1'
list_row='1'
win_width='300px'

copy=' Copy'
save=' Save'
copy_save='Copy & Save'
edit='Edit Screenshot'

# Rofi CMD
rofi_cmd() {
  rofi -theme-str "window {width: $win_width;}" \
    -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$option_1\n$option_2" | rofi_cmd
}

####
# Chose Screenshot Type
# CMD
type_screenshot_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 400px;}' \
    -theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 1; lines: 3;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Choose Option' \
    -mesg 'Type Of Screenshot:'
}

# Ask for confirmation
type_screenshot_exit() {
  echo -e "$option_capture_1\n$option_capture_2\n$option_capture_3" | type_screenshot_cmd
}

# Confirm and execute
type_screenshot_run() {
  selected_type_screenshot="$(type_screenshot_exit)"
  if [[ "$selected_type_screenshot" == "$option_capture_1" ]]; then
    option_type_screenshot=screen
    ${1}
  elif [[ "$selected_type_screenshot" == "$option_capture_2" ]]; then
    option_type_screenshot=output
    ${1}
  elif [[ "$selected_type_screenshot" == "$option_capture_3" ]]; then
    option_type_screenshot=area
    ${1}
  fi
}
###

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
    -mesg 'Copy/save the screenshot or open in image editor'
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
    type_screenshot_run
    copy_save_editor_run "takescreenshot"
}

run_cmd --opt1
