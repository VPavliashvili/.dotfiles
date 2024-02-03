#!/bin/sh

vm_name=""
gui=false
wn=""

# -n -> name of the target virtual machine
# -g -> graphical(otherwise its passthrouged so no need host gui)
# -w -> target workspace number
while getopts 'n:w:g' flag
do
    case "${flag}" in
        g) gui=true ;;
        n) vm_name="${OPTARG}" ;;
        w) wn="${OPTARG}" ;;
    esac
done

echo $gui
echo $vm_name
echo $wn

virsh --connect qemu:///system start $vm_name

if [ "$gui" = true ] ; then
    # virt-manager --connect qemu:///system --show-domain-console $vm_name

    virt-viewer --connect qemu:///system -f -w -a $vm_name --hotkeys=release-cursor=ctrl+alt & disown

    # sleep to wait for hyprland window creation
    sleep 1

    address=$(hyprctl -j clients | jq -r ".[] | select(.title | contains(\"$vm_name\")) | .address")

    hyprctl dispatch movetoworkspacesilent $wn,address:$address
    echo "hyprland -> virtual machine ${vm_name} started with window address: ${address} in workspace ${wn}"
fi
