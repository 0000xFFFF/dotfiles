#!/usr/bin/env bash

WALLPAPER_DIR="/media/SSD/media/bg"

OUTPUTS=$(swww query | grep ':' | awk -F':' '{gsub(/ /,"",$2); print $2}')

mapfile -t SHUFFLED_WALLPAPERS < <(find "$WALLPAPER_DIR" -type f | shuf)

i=0
for OUT in $OUTPUTS; do
    if [ $i -lt ${#SHUFFLED_WALLPAPERS[@]} ]; then
        swww img "${SHUFFLED_WALLPAPERS[$i]}" --outputs "$OUT" --transition-type fade --transition-duration 2
        ((i++))
    fi
done
