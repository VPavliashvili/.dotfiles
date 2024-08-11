#!/bin/sh

json=$(swaymsg -t get_workspaces)
focused=$(echo "${json}" | jq -r '.[] | select(.focused == true)')

current=$(echo "${focused}" | jq -r '.name')
echo "${current}"

vm_name=""
wn=""
additional=""
fullscreen=false

while getopts 'n:w:a:f' flag
do
    case "${flag}" in
        n) vm_name="${OPTARG}" ;;
        w) wn="${OPTARG}" ;;
        a) additional="${OPTARG}" ;;
        f) fullscreen=true ;;
    esac
done

echo $vm_name
echo $wn
echo $fullscreen
echo $additional

virsh --connect qemu:///system start $vm_name

swaymsg "workspace --no-auto-back-and-forth $wn"

if [ "$fullscreen" = true ] ; then
    swaymsg exec "looking-glass-client -F ${additional}"
    echo "run as fullscreen on workspace $wn"
else
    swaymsg exec "looking-glass-client ${additional}"
    echo "run on workspace $wn"
fi

echo "vm command -> looking-glass-client ${additional}"

swaymsg "workspace --no-auto-back-and-forth $current"
