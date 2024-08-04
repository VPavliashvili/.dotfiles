#!/usr/bin/env sh

if [ -z "$1" ]
  then
    echo "No argument supplied"
    return
fi

var="$1"

# clamp the value between -1 and 1
var=$(awk '$1<-1{$1=-1}$1>1{$1=1}1' <<<"$var")
echo 'mouse sensitivity set to ' "$var"

hyprctl keyword input:sensitivity -- "$var"
