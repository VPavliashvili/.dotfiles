#!/bin/sh

vm_name=""
gui=false
wn=""
fullscreen=false
fakefullscreen=false

# -n -> name of the target virtual machine
# -g -> graphical(otherwise its passthrouged so no need host gui)
# -w -> target workspace number
# -f -> open windows as fullscreen
# -k -> start window as fakefullscreen
while getopts 'n:w:gfk' flag
do
    case "${flag}" in
        g) gui=true ;;
        n) vm_name="${OPTARG}" ;;
        w) wn="${OPTARG}" ;;
        f) fullscreen=true ;;
        k) fakefullscreen=true
    esac
done

echo $gui
echo $vm_name
echo $wn
echo $fullscreen
echo $fakefullscreen

virsh --connect qemu:///system start $vm_name

if [ "$gui" = true ] ; then
    # virt-manager --connect qemu:///system --show-domain-console $vm_name

    if [ "$fakefullscreen" = true ] ; then
        hyprctl dispatch exec "[workspace $wn silent;fakefullscreen]" "virt-viewer --connect qemu:///system -w -a $vm_name --hotkeys=release-cursor=ctrl+alt"
        echo "run as fakefullscreen on workspace $wn"
    elif [ "$fullscreen" = true ] ; then
        hyprctl dispatch exec "[workspace $wn silent]" "virt-viewer --connect qemu:///system -f -w -a $vm_name --hotkeys=release-cursor=ctrl+alt"
        echo "run as fullscreen on workspace $wn"
    else
        hyprctl dispatch exec "[workspace $wn silent]" "virt-viewer --connect qemu:///system -w -a $vm_name --hotkeys=release-cursor=ctrl+alt"
        echo "run on workspace $wn"
    fi

    echo "hyprland -> virtual machine ${vm_name} started with window address: ${address} in workspace ${wn}"
fi
