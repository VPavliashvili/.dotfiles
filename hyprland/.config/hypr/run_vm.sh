#!/bin/sh

vm_name=""
gui=-1 # (can be 0, 1, -1. i.e 0 -> default, 1 -> looking-glass, -1 -> no gui)
wn=""
fullscreen=false
fakefullscreen=false
additional=""

# -n -> name of the target virtual machine
# -g -> gui
# -w -> target workspace number
# -f -> open windows as fullscreen
# -k -> start window as fakefullscreen
# -a -> additional arguments
while getopts 'n:w:g:a:fk' flag
do
    case "${flag}" in
        g) gui="${OPTARG}" ;;
        n) vm_name="${OPTARG}" ;;
        w) wn="${OPTARG}" ;;
        a) additional="${OPTARG}" ;;
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

if [ "$gui" = 0 ] ; then
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
elif [ "$gui" = 1 ] ; then
    if [ "$fakefullscreen" = true ] ; then
        hyprctl dispatch exec "[workspace $wn silent;fakefullscreen]" "looking-glass-client ${additional}"
        echo "run as fakefullscreen on workspace $wn"
    elif [ "$fullscreen" = true ] ; then
        hyprctl dispatch exec "[workspace $wn silent]" "looking-glass-client -F ${additional}"
        echo "run as fullscreen on workspace $wn"
    else
        hyprctl dispatch exec "[workspace $wn silent]" "looking-glass-client ${additional}"
        echo "run on workspace $wn"
    fi

    echo "vm command -> looking-glass-client ${additional}"
fi
