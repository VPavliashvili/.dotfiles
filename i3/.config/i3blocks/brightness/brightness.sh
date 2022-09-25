#!/bin/bash
variable=`xbacklight -get | cut -d'.' -f 1`
echo "$LABEL $variable%"
