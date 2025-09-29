#!/usr/bin/env bash

WALLPAPER_DIR="/media/SSD/media/bg"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
swww img "$WALLPAPER"
