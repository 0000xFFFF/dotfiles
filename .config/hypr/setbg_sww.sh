#!/bin/bash

directory="/media/SSD/media/bg"
monitor=`hyprctl monitors | grep Monitor | awk '{print $2}'`

if [ -d "$directory" ]; then
    random_background=$(find "$directory" -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n 1)

    echo "$random_background"

    swww-daemon
    swww img "$random_background"
fi
