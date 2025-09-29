#!/usr/bin/env bash

WALLPAPER_DIR="/media/SSD/media/bg"

# Get a list of monitors
MONITORS=$(hyprctl monitors | grep 'Monitor ' | awk '{print $2}')

# Recursively find all image files safely
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" \) -print0 | xargs -0 -n1 echo)

# Shuffle the wallpapers safely
mapfile -t SHUFFLED_WALLPAPERS < <(printf '%s\n' "${WALLPAPERS[@]}" | shuf --random-source=/dev/urandom)

# Assign a wallpaper to each monitor
i=0
for MON in $MONITORS; do
    if [ $i -lt ${#SHUFFLED_WALLPAPERS[@]} ]; then
        hyprctl hyprpaper reload "$MON","${WALLPAPERS[$i]}"
        ((i++))
    fi
done
